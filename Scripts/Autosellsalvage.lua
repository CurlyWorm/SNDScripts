-- Required plugins: Lifestream, Autoretainer, Pandora's box, sortakinda with top left inventory slot set to salvage only, everything in this slot will be sold to vendor
-- Simpletweaks with the tweaks Estate List Command and fix '/target' command enabled
-- Apartment also needs the mannequin right inside the door so you can use the confirm button to interact with it

-- Only supports up to 8 characters because i didn't need any more
-- going above that will just cause characters to login and then not actually sell anything

-- Change apartmentnumber to your apartment number
-- Doesn't support past first page, easy to add but wasn't needed

apartmentnumber = "3"
homeserver = "Louisoix"
confirmbutton = "G"
estateowner = "PersonWhoOwnsTheApartment"

chars = {
    -- remember to remove the comma from the last character if adding/removing
    'Example character@world',
    'Example character@world',
    'Example character@world',
    'Example character@world',
    'Example character@world',
    'Example character@world',
    'Example character@world',
    'Example character@world'
}
---
--- Nothing below here is meant to be changed
--- Nothing below here is meant to be changed
---
-- Start Login
homeserverlength = string.len(homeserver)
apartmentnumberfixed = apartmentnumber-1
for _, char in ipairs(chars) do
    if GetCharacterName(true) == char then
        yield("/echo Skipping char select since already on first char")
    else 
        yield("/echo "..char)
        yield("/ays relog " ..char)
        yield("<wait.45.0>")
        yield("/waitaddon NamePlate <maxwait.600><wait.5>")
    end
    -- World check and tp if omega
    if char:sub(-homeserverlength) == homeserver then
        -- Do literally nothing
    else
        yield("/li "..homeserver)
        yield("<wait.20.0>")
    end

    -- Tp to apartment and enter lobby
    yield("/wait 1")
    yield("/estatelist "..estateowner)
    yield("/wait 0.4")
    yield("/pcall TeleportHousingFriend false 2")
    yield("/wait 10")
    yield("/target Apartment Building Entrance")
    yield("/lockon")
    yield("/ac sprint")
    yield("/automove")
    yield("/wait 3")
    yield("/send "..confirmbutton)
    yield("/wait 1")
    yield("/pcall SelectString false 1")
    yield("/wait 4")

    -- Move to vendor
    yield("/target Apartment Merchant")
    yield("/lockon")
    yield("/ac sprint")
    yield("/automove")
    yield("/wait 4")

    -- Sell items
    yield("/send "..confirmbutton)
    yield("/wait 0.4")
    yield("/send "..confirmbutton)
    yield("/wait 1")
    yield("/send i")
    yield("/wait 0.4")
    yield("/send i")
    yield("/wait 0.4")
    for n=1, 8 do
        yield("/send "..confirmbutton)
        yield("/wait 0.1")
        yield("/send "..confirmbutton)
        yield("/wait 0.1")
        yield("/send "..confirmbutton)
        yield("/wait 0.7")
    end

    -- Exit shop and enter apartment
    yield("/pcall Shop true -1")
    yield("/pcall InventoryExpansion true -1")
    yield("/target Entrance to Apartments")
    yield("/lockon")
    yield("/automove")
    yield("/wait 1.5")
    yield("/send "..confirmbutton)
    yield("/wait 1.5")
    yield("/pcall SelectString false 0")
    yield("/wait 1")
    yield("/pcall MansionSelectRoom false 0 "..apartmentnumberfixed)
    yield("/wait 0.5")
    yield("/pcall SelectYesno false 0")
    yield("/wait 4.0")
    
    -- Buying from apartment mannequin
    yield("/send "..confirmbutton)
    yield("/wait 0.5")
    yield("/send "..confirmbutton)
    yield("/wait 0.5")
    function cook(item)
        yield("/pcall MerchantShop true 15 "..item)
        yield("/wait 0.5")
        yield("/pcall MerchantShop true 14 0")
        yield("/wait 0.5")
        yield("/pcall SelectYesno true 0")
        yield("/wait 1")
    end
    if _ == 1 then
        cook(4)
    elseif _ == 2 then
        cook(8)
    elseif _ == 3 then
        cook(16)
    elseif _ == 4 then
        cook(32)
    elseif _ == 5 then
        cook(64)
    elseif _ == 6 then
        cook(128)
    elseif _ == 7 then
        cook(256)
    elseif _ == 8 then
        cook(512)
    end
    -- return home
    if char:sub(-homeserverlength) == homeserver then
        yield("/tp free company")
        yield("/wait 10")
    else
        yield("/li")
        yield("/wait 30")
        yield("/tp free company")
        yield("/wait 10")
    end
end

IncludeLib("ITEM");
Include("\\script\\dailogsys\\dailogsay.lua");

----------------------------------------------------Bach Kim -----------------------------------
function main()
    bachkim_main()
end

function bachkim_main()
	local szTitle = " Xin chµo <color=red>"..GetName().."<color> !Hoµng kim nh­ NhËt - B¹ch kim nh­ NguyÖt?<enter> Ta cã thÓ luyÖn hãa c¸c lo¹i Tiªn khÝ, cÇn cã Tiªn ngäc"
	local tbOpt={
        "LuyÖn hãa Tiªn khÝ/make_bachkim",
		"Kh¶m c­êng hãa ThÇn khÝ/up_bachkim",
        "Tho¸t/no",
    }
	Say(szTitle, getn(tbOpt), tbOpt)
end

function make_bachkim()
	GiveItemUI("T¹o ThÇn KhÝ","§Æt Tiªn khÝ vµ Tiªn ngäc vµo", "do_upgoldeq_process",1);
end
function do_upgoldeq_process()
    local soLuongKimTinh = GetItemCountEx(273) -- Kim Tinh (B?ch Phi?n Tinh, ID: 469)
    local nItemIndex = GetGiveItemUnit(1) -- L?y ch? s? v?t ph?m Hoàng Kim dã n?p
    local nG, nD, nP = GetItemProp(nItemIndex) -- L?y thông tin v?t ph?m (Genre, Detail, Particular)

    -- Ki?m tra v?t ph?m có ph?i trang b? Hoàng Kim không
   -- if nG ~= 0 or (nD < 1 or nD > 12) then -- Ki?m tra xem có ph?i trang b? không (gi? s? G=0 là trang b?, D t? 1-12 là các lo?i trang b?)
        --Talk(1, "", "V?t ph?m này không ph?i trang b? Hoàng Kim!")
     --   return
   -- end

    -- Ki?m tra s? lu?ng B?ch Phi?n Tinh
    if soLuongKimTinh < 1 then
        Talk(1, "", "B¹n cÇn cã Tiªn ngäc ")
        return
    end

    -- Ki?m tra s? ô tr?ng trong túi
    if CalcFreeItemCellCount() < 1 then
        Talk(1, "", "Kh«ng ®ñ « trèng")
        return
    end

    -- Th?c hi?n nâng c?p
    local strItemOld = GetItemName(nItemIndex) -- L?y tên trang b? tru?c khi nâng c?p
	local nResult = UpgradePlatinaFromGoldItem(nItemIndex) -- Nâng c?p trang b?
    if nResult ~= 1 then -- Gi? s? hàm tr? v? 1 n?u thành công
        Talk(1, "", "Kh«ng thÓ N©ng cÊp")
        return
    end
	DelItemEx(273, 1)
    SyncItem(nItemIndex) -- Ð?ng b? v?t ph?m sau khi nâng c?p
    local strItemNew = GetItemName(nItemIndex) -- L?y tên trang b? sau khi nâng c?p
    AddGlobalNews("<color=yellow>".. GetName() .. "<color> ®· luyÖn hãa tiªn khÝ <color=yellow>"..strItemNew.."<color> thµnh thÇn khÝ.", 1)		
	Msg2Player("LuyÖn hãa thµnh c«ng!")
    Talk(1, "", "LuyÖn hãa <color=yellow>" .. strItemNew .. "<color> thµnh c«ng")
end

function make_bachkim_max()
	GiveItemUI("C­êng hãa ThÇn KhÝ","§Æt thÇn khÝ vµ tiªn ngäc vµo", "do_upgoldeq_max",1);
end
function do_upgoldeq_max()
	UpgradePlatinaFromGoldItem(GetGiveItemUnit(1))
	for i=1,10 do
		UpgradePlatinaItem(GetGiveItemUnit(1))
	end
end

function up_bachkim()
	GiveItemUI("C­êng hãa ThÇn KhÝ","§Æt thÇn khÝ vµ tiªn ngäc vµo", "upgrade_bachkim_process",1);
end

function upgrade_bachkim_process()
	local soLuongKimTinh = GetItemCountEx(273) -- Kim Tinh (B?ch Phi?n Tinh, ID: 469)
    local nItemIndex = GetGiveItemUnit(1) -- L?y ch? s? v?t ph?m Hoàng Kim dã n?p
    local nG, nD, nP = GetItemProp(nItemIndex) -- L?y thông tin v?t ph?m (Genre, Detail, Particular)

    if soLuongKimTinh < 1 then
        Talk(1, "", "B¹n cÇn cã Tiªn ngäc")
        return
    end

    -- Ki?m tra s? ô tr?ng trong túi
    if CalcFreeItemCellCount() < 1 then
        Talk(1, "", "Kh«ng ®ñ « trèng")
        return
    end

    -- Th?c hi?n nâng c?p
    local strItemOld = GetItemName(nItemIndex) -- L?y tên trang b? tru?c khi nâng c?p
	local nResult = UpgradePlatinaItem(GetGiveItemUnit(1)) -- Nâng c?p trang b?
	 Talk(1, "", "N©ng cÊp thµnh c«ng!")
    if nResult ~= 1 then -- Gi? s? hàm tr? v? 1 n?u thành công
        Talk(1, "", "Kh«ng thÓ N©ng cÊp")
        return
    end
	DelItemEx(273, 1)
    SyncItem(nItemIndex) -- Ð?ng b? v?t ph?m sau khi nâng c?p
    local strItemNew = GetItemName(nItemIndex) -- L?y tên trang b? sau khi nâng c?p
    AddGlobalNews("<color=yellow><bclr=red>" .. GetName() .. "<bclr> ®· c­êng hãa thÇn khÝ <color=yellow>"..strItemNew.."<color> thµnh c«ng.", 1)		
	Msg2Player("LuyÖn hãa thµnh c«ng!")
    Talk(1, "", "N©ng cÊp thµnh c«ng!")

end
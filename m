Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001ABC6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 03:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FftH3wi/eEbeK4fUdQm0pQADr7Heg2nBQVvWNGIN90c=; b=ujubSY/64VB6ZvAjk3VbQsawMk
	imijCQBsmy867FsMNew9Sgq4W5WQJ2Sy4sfpIYivwKb7IJ53WgvDO4tOrKB3jscPYOJnX6xs+GasC
	pDrM4uDJwpK4NAM0Vf8oHM48EEfzyEAQeSSvmfZPnDdAhs+Huw3Ck8zpcW118p3hvhTstxI9xdPGj
	u8GexoATKDfsROXTpCq9Z3RGpsciM7BCWu3CoMKrAKzfQ738fKfaCa5kL3hAWBhMdFEUc03eXIt56
	CEWIug9L+MBAahHVSK/ZiZrTaXAU+8gPJ89cVvXmIIMfncUAWFmlSPkADVGiybwzlif8VTLuElkFT
	8cjCdhXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrrm8-0000000Ds75-2AZT;
	Wed, 03 Apr 2024 03:59:00 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrrm5-0000000Ds5n-1SwY
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 03:58:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3CFEDCE1F6C;
	Wed,  3 Apr 2024 03:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57539C433F1;
	Wed,  3 Apr 2024 03:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712116734;
	bh=WsY/TNsEXjthucfE5va9e+m05l9sgv1UbriWKESjJ7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TnVAISckYGOK578QZvqWjsbafhEKXwBgnAEZm5jAuLBn59H3EgOo989qVebHS6kFd
	 4S+MLbOKEX/3bnE1oW/U2yoGRH2dZ1cRuwHuj3aEsDmpFAqtAmCaqyGqxt2xDQZ7sw
	 GYjUPMGsP0LXPYwc45HuYrvaJOu5WlM2xI26yc4Pf4zKbfCOnzZE/G+4M/4B4DM5Xs
	 iR+4wKr83LsWFGcoYdGg4VBhdgc6dGxi2DkhWbIxePR0+wDmaeQSZJojJE6xODfBp9
	 ukS9rKhqbFZtxtUNlJ3CjyhtWLziCc2lvRV6yefMK1yA8Ro0pllMtVRH8sEt1Lrmb4
	 rdXTpRnkd4gZg==
Message-ID: <3b35dca4-e548-427b-a304-e21f3ee483e0@kernel.org>
Date: Wed, 3 Apr 2024 12:58:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/28] null_blk: Introduce fua attribute
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20240402123907.512027-1-dlemoal@kernel.org>
 <20240402123907.512027-18-dlemoal@kernel.org>
 <7a3be43c-39d9-472a-9593-89a1c4e03004@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <7a3be43c-39d9-472a-9593-89a1c4e03004@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_205857_667073_53342FB7 
X-CRM114-Status: GOOD (  11.20  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/3/24 12:56, Chaitanya Kulkarni wrote:
> Damien,
> 
> On 4/2/24 05:38, Damien Le Moal wrote:
>>   +static bool g_fua = true;
>> +module_param_named(fua, g_fua, bool, S_IRUGO);
>> +MODULE_PARM_DESC(zoned, "Enable/disable FUA support when cache_size is used.
>> Default: true");
>> +
> 
> checkpatch is generating warning on this patch, please check :-
> 
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal
> permissions '0444'.
> #31: FILE: drivers/block/null_blk/main.c:229:
> +module_param_named(fua, g_fua, bool, S_IRUGO);
> 
> Also, I noticed that for zone_append_max_sectors attribute patch
> you are using 0444 but for fua you are using S_IRUGO, any specific
> reason ?

No particular reason. I probably followed the pattern around the code when I
added it.

Personnally, I find this checkpatch warning about S_IRUGO silly as it is far
more readable than 0444... Just my 2 cents. I can make the change if you insist.

> 
> -ck
> 
> 

-- 
Damien Le Moal
Western Digital Research



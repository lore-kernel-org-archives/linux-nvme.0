Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F7DC61DE8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 22:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:To:From:Subject
	:MIME-Version:Date:Message-ID:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mMyAN6qvl3R6GI3tDWciEu1BMF8rE7rkRCkPjr6HPr4=; b=HMjSA5UXojMMcfgmS7Iuf2GmMX
	rmgwxCEHshbqPeHUWXisAMaLFdbmbQQ6L1laNQazuWnnYgYFv2waECQS9iNeyZjTJ9dt7yCJZ/mYH
	C1IFPokTkw1Tmyo3VYuMRu7PvwNj3dgGjrdCGnlZkcrnAEUD1FaQJ4qS9GM963IusSJEuk0IC2cRF
	4XER8lpPi2lvNurLToGj9cmLFvtsbfMykbmdk4FbZFmG7EvpaSt37MHvE5G042Jqzs+vqj2bkbU/I
	5SL7zxfMo4lzof+rPgtmWjfo1WzYTdxzl29x+Hk9kw7sTGmAexPoZoZb7+aYPWJ03WOM+SOdUK+w8
	KhbIN+4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0o5l-00000008BoP-0S9N;
	Sun, 30 Aug 2026 22:33:33 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0o5i-00000008Bnl-1TKj
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 22:33:31 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so26983425e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 15:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788129208; x=1788734008;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:reply-to:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mMyAN6qvl3R6GI3tDWciEu1BMF8rE7rkRCkPjr6HPr4=;
        b=sDhf7l7PUvZh3egAbHOvXH5Sji/A4Q+dQjXkwacjES/Muz8QJRzg06ONtrAimRGavf
         SpiUOzLF84fJMchMgJtABEzseTDZ/Lrl0I/yvVXc+2q/Fs0GcXsOO9E6N77S/Rv8JSNB
         0DOwZVW+3RU73vzbvndO3AAoFVxbAdV3wdE/Lyx1RH5yutS4m5FpfKvTC4DaTKtf8sZy
         JaPwST/Z3Rta22juxmCBMkfkmuCtfaWW6Y/qogBsgT8ebd0fu8qy2qzHne+xQW8G+VM1
         qKvAgjC9vu7EI5x5RMhXWNIM9GeXpfyMnraQ8uTX7Me04ASN7IJR2rzd9tk69U+41OPW
         IDIA==
X-Gm-Message-State: AFuF++mdyA3v8CMjXyPkNBt2SKz2lNYm5VZqKLrchVEl6QImfPvJjkU3
	zu7APcf5nCOuktJTucIM1Z/lW5KszRPPd2HfuhPonbl1Yw7y2/NkTz7J6Fy4XdmJMDo=
X-Gm-Gg: AR+sD12ISJp7afrzHY9xPANfUtpq3BqYT3qSExyii1zZsbLkWfKyl912/OJo1mdkD62
	Q5MCWqIi8qfgNRiCFLWOCYPqeAVzvcYfY84Jc3zSGHG0cDWbZze/FWD7YPqwDn1JEwwdLD7dtZi
	jKRbt9WuxFXCZQ1F6K+bDhnZNQJ2urQF4HwQAvl7Rr+VST2HRgQPWNc16E0w5hhIVa0mjuztEDm
	SXcTD/MZoL9SJYsY+Il0I5NBKOhA/SLaJ3kqLgki7917/wNn0Ss8tk/nx2E2V0J7t+J9B7Lvgpl
	xj6tkPN9iKoVqusFOxeWGrS3gzb2PHvjlYttgrUmNeR1TO6wo1ga0s1Uez9n5IX2WQ8lsEdCEI5
	zJao3/Yb4FUe9k7DWBDuWCxg9eoqtUv/I8idphE0/xNBkD0Iy5dgBNOaGo+7jLDXHwRusV0n2pA
	OWBRc0mhRmWW4J/XC8GC4aFPXMeQ4a/jUjPi6BTul9E92GPQigjRCALXiX6ZthXgdX3u/fYMKp5
	b8LywZ7jnO9R7uQjeBK2w==
X-Received: by 2002:a05:600c:8b6b:b0:49b:c8e:8e6 with SMTP id 5b1f17b1804b1-49b91bd99b7mr360943975e9.0.1788129208055;
        Sun, 30 Aug 2026 15:33:28 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9266be71sm503352635e9.2.2026.08.30.15.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 15:33:27 -0700 (PDT)
Message-ID: <77a96e27-d983-46ff-a4ce-2c1cffc68840@grimberg.me>
Date: Mon, 31 Aug 2026 01:33:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix cntlid uniqueness check for different hosts
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
References: <20260823001509.119740-1-sagi@grimberg.me>
Content-Language: en-US
In-Reply-To: <20260823001509.119740-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_153330_396216_DF57DFBB 
X-CRM114-Status: UNSURE (   8.48  )
X-CRM114-Notice: Please train this message.
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
Reply-To: sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 23/08/2026 3:15, Sagi Grimberg wrote:
> A single physical host may use a separate {hostnqn, hostid} identifiers
> when connecting to a controller. It is possible that the a distributed
> nvmf controller may generate unique cntlid per hostnqn and not globally
> unique. Hence, validate the cntlid is unique per nvmf host.
>
> Fixes: 1b1031ca63b2 ("nvme: validate cntlid during controller initialisation")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Any thoughts on this one?


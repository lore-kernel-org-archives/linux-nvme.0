Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NAME_EMAIL_DIFF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B960C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 07:46:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A3E2220B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 07:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A3E2220B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0Co9PA1OSiEi+OlASl/wfcShIV666X8forcjReMOgVA=; b=b9zVhRY/+VNTgDDzHEeurUJvm
	PgDZKkOmU0USVDMm7WKDqmIPnIis+7J0G0+7X/kHt+5HLbk/7XOu381bV2fEQfcz6sT10g7+fwbo2
	TyqnAq1z4BKePuAX8962PmJUKjrI+lTPT+P95WbWhY63cDFufULKtzSfMJk4Oak/bp1i+ETwiEFWH
	tEchxCPVuuFjlyxmLaWf11XnLokPp0s4qcPWazHClHQepHD5RD5EoUVmBT3IGn6pNrvl3KNSPxk2f
	aqFGkUf5ErJUt5jutlJ5AeWu/6Z9tjWHB3cOfObSRohd5WbHyARiGAIowcxZRGRYruCb3gFVLt9qa
	taV6HljJw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmBE0-0006Ab-Uw; Mon, 07 Dec 2020 07:46:25 +0000
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmBDw-00068H-Vp
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 07:46:22 +0000
Received: by mail-ej1-x641.google.com with SMTP id jx16so18056606ejb.10
 for <linux-nvme@lists.infradead.org>; Sun, 06 Dec 2020 23:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=H37Uk/40yzLuHJ510VKEIUp0RQ+PZefPT2yeqkErhUg=;
 b=YByJcKFlSczTgeZhju2uMm2NIdVWlh4zrHYMrf3feowxRHe1DgmrNadEvKp0ryXkAD
 PHlRZYwLszOen49P72OgOB7Yj0Z+HpY1GCwebiYBeEE/z7vT/YGPsh93c59nBPxmmiTF
 oMYzfSvvVxEU5/c4xGYgMBzq8masamx5nngKqEMmSEXAyVMHp6qZcJJqPn1Zu44/rhaZ
 tXoZT2sgg7ez8d/yjs3MjMK78x+gcGqAWfBTY5z6XJw3imuAh+P42MgKSVg5pKTepXA8
 3cSIMENmKsR1Qaq6H/bI2QwgvzubzwqfBEhgaqqb9BHqcMWehuHIBKrE1aGcH44iRWjx
 hTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=H37Uk/40yzLuHJ510VKEIUp0RQ+PZefPT2yeqkErhUg=;
 b=Ja4lcZriSe8rlz3e2p3+hBVV/QMdsPfgFhvDnUmNsZYKJnnUBuBTmFu123SI5td2+Y
 6G4rsI1mUo0J9Oxkh9LYHoUZ+Ok+iJ3t0/GXMPWX/IXT51lJFqFCmWxw6BDdUy+k8kG7
 RdYODwTKZA4LB72P1DVL7ajLHsaEis4ra+iwtaycQ392zWH4vTOTSLN86TDH9+QctWLq
 DxPHjR46USuK6iHvshNv+fcKE4mVJO2c0eegHUuysmZju1JqkFjlwj9cwiARsJUTvhTv
 WpimJo84GVKFfM4PbST0CBYVC6u+Qc/KOyYLLf22CkaaIypr+EeaI5CrdPb0FtQyWNfT
 5fRA==
X-Gm-Message-State: AOAM532a2CC/n22lsHJkV088j2DTdsCOBrQiXOtIWJoaYU6PACTxJ+uc
 IJ7oT7mUpDK2DEzOUSLvicTPjA==
X-Google-Smtp-Source: ABdhPJzIa5O3cMvuafw6M6JqsvV9/GygQAIh8T7eOMf7z+MaNcc/rzLLg6xADVx25y95wFRUKMw1cg==
X-Received: by 2002:a17:906:12cf:: with SMTP id
 l15mr17565338ejb.540.1607327177482; 
 Sun, 06 Dec 2020 23:46:17 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id z96sm5951767ede.81.2020.12.06.23.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Dec 2020 23:46:16 -0800 (PST)
From: "javier.gonz@samsung.com" <javier@javigon.com>
X-Google-Original-From: "javier.gonz@samsung.com" <javier.gonz@samsung.com>
Date: Mon, 7 Dec 2020 08:46:16 +0100
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Message-ID: <20201207074616.mocdy6m5qgsn6yqg@mpHalley>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <CH2PR04MB6522F1188557C829285ED5E8E7F10@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20201204144003.GA8868@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201204144003.GA8868@redsun51.ssa.fujisawa.hgst.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_024621_172290_7A91341D 
X-CRM114-Status: GOOD (  22.82  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "selvajove@gmail.com" <selvajove@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>, "hch@lst.de" <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 04.12.2020 23:40, Keith Busch wrote:
>On Fri, Dec 04, 2020 at 11:25:12AM +0000, Damien Le Moal wrote:
>> On 2020/12/04 20:02, SelvaKumar S wrote:
>> > This patchset tries to add support for TP4065a ("Simple Copy Command"),
>> > v2020.05.04 ("Ratified")
>> >
>> > The Specification can be found in following link.
>> > https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
>> >
>> > This is an RFC. Looking forward for any feedbacks or other alternate
>> > designs for plumbing simple copy to IO stack.
>> >
>> > Simple copy command is a copy offloading operation and is  used to copy
>> > multiple contiguous ranges (source_ranges) of LBA's to a single destination
>> > LBA within the device reducing traffic between host and device.
>> >
>> > This implementation accepts destination, no of sources and arrays of
>> > source ranges from application and attach it as payload to the bio and
>> > submits to the device.
>> >
>> > Following limits are added to queue limits and are exposed in sysfs
>> > to userspace
>> > 	- *max_copy_sectors* limits the sum of all source_range length
>> > 	- *max_copy_nr_ranges* limits the number of source ranges
>> > 	- *max_copy_range_sectors* limit the maximum number of sectors
>> > 		that can constitute a single source range.
>>
>> Same comment as before. I think this is a good start, but for this to be really
>> useful to users and kernel components alike, this really needs copy emulation
>> for drives that do not have a native copy feature, similarly to what write zeros
>> handling for instance: if the drive does not have a copy command (simple copy
>> for NVMe or XCOPY for scsi), then the block layer should issue read/write
>> commands to seamlessly execute the copy. Otherwise, this will only serve a small
>> niche for users and will not be optimal for FS and DM drivers that could be
>> simplified with a generic block layer copy functionality.
>>
>> This is my 10 cents though, others may differ about this.
>
>Yes, I agree that copy emulation support should be included with the
>hardware enabled solution.

Keith, Damien,

Can we do the block layer emulation with this patchset and then work in
follow-up patchses on (i) the FS interface with F2FS as a first user and
(ii) other HW accelerations such as XCOPY?

For XCOPY, I believe we need to have a separate discussion as much works
is already done that we should align to.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

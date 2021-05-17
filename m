Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EC5C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 18:48:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3240361002
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 18:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3240361002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ok3r+yRA+pMC8jfryDfmG335vlLZMprt+suyGFkjwRQ=; b=lKMqEUEmGRryljoVmdtpI674t
	dajurmw5le8Sf+xgj5av9xcVmdfnG3FL7CjhlYnZORmhIQKG8sLqmu4GgCr1Xw+Ae4mwqb418fKKy
	Xk17kL/1aLiW7DfhMqd/Mr3skmPCD+WTmnSE43pIi8KMY/7AOmU2X67BECfP8wrYG5u5E1a4pYabJ
	h41af2a2sX94hfCPyBDM07vh+rAKBoHnvk5eLTDHUmWOEBerb1mXYnUgKQLLcg5V2O1r+AwQeF6LP
	ONr7LfuOAs6F+xB+FaY2vtJXF7kLuKY49mfYjrZ8On1pj5PLMfgCmgB/mtkXS4lyocmckVk9YfCRY
	NdBweAQrw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1liiHQ-00Fs8w-7g; Mon, 17 May 2021 18:47:52 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liiHN-00Fs1y-H9
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 18:47:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=IdzZvRKE8ZlsdcUfyLKHrz1/ThkaYiA3LTDPmY/c/rE=; b=rYI02KZPTvV7MpyA/y+c3ONeZp
 6O28ZY9MmQ2FU0h4ROMJgGxWp8zLTqdbO0SEj18CKqCdSh8DAu7k6ZpTpiXIq7/KpwnVRJLpMTNDP
 kw4Vd/WxOEJwq/1hxDtUoKBcI9TitrF41YYci/H9t/MiEYAveV+HpAhgrTDJ+6bdyUIlE+PIkE5N+
 ErCX1V6rCjBnauEy08GrXEiMmyYpPfMce6Dc0LJq7N/l0AXt8buzOcBnXBOTSxc2dzp+Dm8HXAUWH
 ack2Pc2YnLbdElI5NtxYKbNERlw8K2yakLBuqjmTp+TH7c8VIzF8ddo+CTiKrEiwREPmUApCxqvzF
 8rvvhatQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liiHK-00E4Js-M8
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 18:47:48 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B54E860FF0;
 Mon, 17 May 2021 18:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621277266;
 bh=C2QIqm6xMSJai6r45GoGr4DzcxKYFR733cmwGy2FkVk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=shQyBbAK2z3ZOWdyC92ui9vgE6wBjHZmDm+V1nybTQtbA30ZxsfM/dM06Kac70nG7
 96iCxxBlUQpdusuF7dgNI7a60IDR6mUarav4auoYtwU7tZCipd0C3PQBlbFbmOFZje
 MQGE+DtyO681r18Y20o5zIO9FoYTBg1UzXOKQ4PLcLYOpWVOUZPU84w3/w28N1UbWu
 TyLQSKenOgpEcUsirAYEOLwm/izOC6a3KSBDLqMZBSaIduFCnL+9NlU6wLyMHYZBwD
 CAcbsvY8WfL3M/6hwrCrXqQ4fT0grLEu+iRroODTSvPtDA0faWsbUOAX8EybySSn+Y
 88sr0tTRgUEEA==
Date: Mon, 17 May 2021 11:47:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH 0/3] nvme: protect against possible request reference
 after completion
Message-ID: <20210517184743.GD2709391@dhcp-10-100-145-180.wdc.com>
References: <20210517175955.602725-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517175955.602725-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_114746_766047_4A1E8868 
X-CRM114-Status: GOOD (  18.94  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, May 17, 2021 at 10:59:52AM -0700, Sagi Grimberg wrote:
> Nothing in nvme protects against referencing a request after it was completed.
> For example, in case a buggy controller sends a completion twice for the same
> request, the host can access and modify a request that was already completed.
> 
> At best, this will cause a panic, but on the worst case, this can cause a silent
> data corruption if the request was already reused and executed by the time
> we reference it.
> 
> The nvme command_id is an opaque that we simply placed the request tag thus far.
> To protect against a access after completion, we introduce a generation counter
> to the upper 4-bits of the command_id that will increment every invocation and
> be validated upon the reception of a completion. This will limit the maximum
> queue depth to be effectively 4095, but we hardly ever use such long queues
> (in fabrics the maximum is already 1024).

This is a neat safe guard even though we haven't seen much indication of
this type of controller bug occurring on PCIe.

It looks pretty light-weight, but I would like to see if this has a
performance impact. I'm still 3 weeks away from physical access to my
site to set up a performance test with my low-latency devices, though.

On patch 2, I think it's safe to just cap the queue depth to the new max
rather than return an error if the user requests more. 4k actually seems
like quite a lot there, too. 1k should be plenty just like the fabrics
transports, and a 1k limit provides 2 more bits for the gen sequence.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

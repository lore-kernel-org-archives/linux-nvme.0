Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D713CC433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 19:33:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A07264D9A
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 19:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A07264D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yhqjhdMvVPB5W7ZjpThI2cCRf2k9vxbx43s4iPieOlQ=; b=NOIeYat7eYZQUnv7Baf6RYbGT
	R5R+ps6xSdRfDVopkUhHz7CtSCIe3smrYLpZaORx8XL6xK36XuLlV13mb82oLJUWPjjaGV+vZWkX9
	jWs8hbRA1oLNWkNr6ujQiyNQwvxelubAef4oIAGwXLz2jTWWqZDyPFLE5Zk0S08iww3TJbr31ntt2
	cU3gsnMbOa5Nt/Tltt7EzaMPDgbK68bj1FHXAJvN/PROlxU0Xnvhxoy1PasfGuYoiF8OCH5FAL5bD
	qg5GX22ttgygep0xOt3xrKVKrTIDbIZUwWbBf85s/xN5w9fHjkhlk/fGxOLzXVYkTJ7cDtdAiSTjq
	m65v5c7yQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5ZWb-0002Dk-QB; Fri, 29 Jan 2021 19:33:45 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5ZWU-00028e-6M
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 19:33:39 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611948811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dyhQ59+E3Uf5b1hSKXTEukqXIDtOA8Pnzo9p7g/InQY=;
 b=Fw+a5D+JBjS2Ovb4cQIb8SfeRJqydJvNPFwN6Br2U/JAL5TdaGgMXtkn2z5nygn1wYfVmw
 t9/UstwAHofLGER96nNiJ8+usWgjiqMgW4tj7RNLwPRLrjiEfMdpIqouFoLWiZex+BYADU
 zeEtRmXtMbL7C5HDQ4MUSUomiHOAjao=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 84B37B0EA;
 Fri, 29 Jan 2021 19:33:31 +0000 (UTC)
Message-ID: <cbf4808b0becc3978b758d5be5cc3f3c1c6fe86f.camel@suse.com>
Subject: Re: [PATCH 11/35] monitor: add option -A / --autoconnect
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org
Date: Fri, 29 Jan 2021 20:33:30 +0100
In-Reply-To: <d9c74675-a324-b863-1dee-454fc90d5e77@grimberg.me>
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-12-mwilck@suse.com>
 <d9c74675-a324-b863-1dee-454fc90d5e77@grimberg.me>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_143338_420607_6E30D509 
X-CRM114-Status: GOOD (  10.93  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, 2021-01-29 at 10:59 -0800, Sagi Grimberg wrote:
> 
> > With this option, the monitor will try to connect to newly
> > discovered
> > controllers.
> 
> Maybe I'm missing something here, but what does it do without
> autoconnect?
> 

Basically it just runs "nvme discover". When events come in,
it runs the discovery and prints the results, like "discover" would.

We can change that of course.

Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

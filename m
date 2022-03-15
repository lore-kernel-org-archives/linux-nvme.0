Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EFAC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 08:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PaK+sfNxncGxuFch7a+KSIuv4lk1f5kCZ9sGkOo2U2U=; b=opAhiJeVlp3wTnFwnio0uvpWeN
	FKOH0idOPm0NP3S3duemgvSpNGoQdOeTMubDLsIn1Sdp6bQSAF5GVH+C9pqXEWDVEDlDmO3l09qAb
	CuR99E8hrbdPpPH9qE3qJQKK05WwYzQMetg5gTje6rTF8ldt4t1tpDm8OcawyV5MjLs5VwqLadj0d
	rdvKTQZBRj4wrSHt+NDuVLSF8EEerNVR2VDJnvnfFxO+qqn5vJzp5r4hxf3eRIVbvxeHutypL4B+B
	bOaAo8RguDFVZYN1fmruExC0mJxSXdG77WKHKUYU2+5ciQuHv6P/xRtssnP+9jK4uq6O03Kwwgxxz
	HJ8eGEtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU2C2-008DYj-J7; Tue, 15 Mar 2022 08:06:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU2Bz-008DYA-5w
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 08:06:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DED9D68AA6; Tue, 15 Mar 2022 09:06:02 +0100 (CET)
Date: Tue, 15 Mar 2022 09:06:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
Message-ID: <20220315080602.GA3082@lst.de>
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314105333.56714-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_010607_394630_63C654AB 
X-CRM114-Status: GOOD (  12.96  )
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

On Mon, Mar 14, 2022 at 11:53:31AM +0100, Hannes Reinecke wrote:
> Expose the discovery subsystem in sysfs instead of having it as
> an internal structure. This requires the admin to manually
> enable the discovery subsystem by linking it to a port, but
> this can be seen as a feature as it will allows us to expose
> subsystems without discovery subsystems and discovery subsystems
> with no I/O subsystems.

... and completely breaks any existing setup.


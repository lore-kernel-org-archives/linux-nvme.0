Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011A0C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 13:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BnamPJQTmPfhgqJ/xFfVUtL3oumrzx68PEUmlDh+0Ws=; b=KuJCJrTklq5lOf71U+xRJObRCJ
	XeFloqPYYwng9dL5HOYBhFw5hl5mvkJjFMQloWYnrP2hTxWENhr/g6GIiUMhdIAiR5tHt92mH0MGW
	NtJHjkQknCj3QslDIsxOBydjiT5MvJKX/kwibycpASR0ChFtRwsGjThnvDJWY6l/vjPoyzIL2C2Z+
	ATVBMzLI2yGQCsnrdz8eiU4viTnK2qJL1dY8TnW/MpmKZqQCK7+BfhepxeVeM2Bk7hmry1WgieISC
	2cORhjqE8PFvhh8Ate4H+WBcgGNhTYz81pTkTwa/edW4Q66n6eah/FTpkCGodovw9D7DQq8gc5IH9
	fQnm6K7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbitm-0013qo-0l; Tue, 05 Apr 2022 13:07:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbiti-0013oS-DO
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 13:07:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649164015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BnamPJQTmPfhgqJ/xFfVUtL3oumrzx68PEUmlDh+0Ws=;
 b=JCoxqw0A0WfigZVZloz8+tJofO0OYeiHwBp4DdGMdXZyUfYLcPE8NbXCaQMqtzPWGnLo89
 z60g195JqKX5JIw8R9FOqeqWTDD2T3hY/atCbenvoY51AOf/EaLxl3ro01w0WL/DT/uADs
 r5+5iZA3Xp2E1U6JdqOgbMoJQVtES8k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-3PGmkeQiOoyUS4oCJceSCQ-1; Tue, 05 Apr 2022 09:06:52 -0400
X-MC-Unique: 3PGmkeQiOoyUS4oCJceSCQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E16B811E80;
 Tue,  5 Apr 2022 13:06:52 +0000 (UTC)
Received: from [10.22.18.217] (unknown [10.22.18.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 189DE404729C;
 Tue,  5 Apr 2022 13:06:51 +0000 (UTC)
Message-ID: <bea2ac73-b542-0479-ccd4-520309549672@redhat.com>
Date: Tue, 5 Apr 2022 09:06:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/3] nvmet: check for subsystem type in
 nvmet_find_get_subsys()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-2-hare@suse.de> <20220405054536.GB23466@lst.de>
 <1c44e4aa-f966-5767-a147-a7f24f6753ee@suse.de>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <1c44e4aa-f966-5767-a147-a7f24f6753ee@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_060702_856255_BF31693E 
X-CRM114-Status: GOOD (  17.00  )
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

On 4/5/22 01:53, Hannes Reinecke wrote:
> 
> Will have to check; might be that this is a left-over from the previous attempt of handling discovery subsystems just like any 
> other subsystem.
> 
> However, this is just part of a larger patchset to support unique discovery controller NQNs. And the overarching question here is:
> 
> Do we want to support unique discovery controller NQNs in nvmet?
> 
> Previously there was a rather strict policy of implementing only the bare necessities in nvmet, and unique discovery controller 
> NQNs is arguably not a necessary thing.

I think the question is: do we want to support unique discovery controller NQNs at all?

> So the whole discussion gets pretty pointless if we decide _not_ to support it after all.

I'm really concerned about the idea of having NO support for unique discovery controller NQNs in nvmet.  If Linux is going to 
support unique discovery NQNs in nvme/host then I think we need to have support for unique discovery NQNs in nvme/target.

Without this, there is just no way to test anything.  I want the ability to test NVMe protocol features like this w/out having 
to rely on external hardware, if possible.

/John

> Cheers,
> 
> Hannes



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB85C83F1B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jul 2025 15:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0IyO+0PgVVEuhA/+ft9xr/Zox0Dy2nwPZuB71xE9fB8=; b=P748iiJD/yycgt6UCGnGBiyKCh
	AZc/SuftC4aTDNu3eMpEVeRSdrjY6jGTTCSMieYIyCjaseOPLc3FdU+gVG0lUOMKcNswu37MjzJI6
	algCGfEZqnO8ofCW6JfK9Ho4du6sEpHIoUG3NlDacso8e/XY0mRCS3kQiTszMCVO7BvQmZv2l/3HF
	k5TmQkwLU4WmdZ+33B7AbB3t0Aq3pYoEnaEmKQPypaIIZa4JW98OS6JdlD7ig91Yg7Bl3Hk0XS085
	bP+mBrMof1KTKxPEk7n4mEGBJxxjY0c9CwKZ0zNpkJivgfXUC283KLWS0SkTsxO3QFohOBYPtxv88
	QCytj7lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaFs1-0000000FAcu-0BDz;
	Fri, 11 Jul 2025 15:41:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaF84-0000000F4cN-20tD
	for linux-nvme@lists.infradead.org;
	Fri, 11 Jul 2025 14:53:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752245614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IyO+0PgVVEuhA/+ft9xr/Zox0Dy2nwPZuB71xE9fB8=;
	b=UyyuYjWUpsf86RtHAnE/+fpvoxun/mZIfbYXi6URmNVVU83NOHfGKRXuGicYLyaMSENgUm
	I2foOzUDEyooAEH6xOqb+TGBCN4WJrTc8pCIfTtY1FTmRH3a3H/XDvEeBeUtUB/EDozbQ5
	nHiFy0Mv4fllSHI13wv2FoMXUFHM584=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-RffQQwO2OBOf4hwzgpwDVg-1; Fri,
 11 Jul 2025 10:53:33 -0400
X-MC-Unique: RffQQwO2OBOf4hwzgpwDVg-1
X-Mimecast-MFC-AGG-ID: RffQQwO2OBOf4hwzgpwDVg_1752245611
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E9F318011CD;
	Fri, 11 Jul 2025 14:53:29 +0000 (UTC)
Received: from [10.22.88.94] (unknown [10.22.88.94])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B7ACE19560A3;
	Fri, 11 Jul 2025 14:53:24 +0000 (UTC)
Message-ID: <694235ed-f714-41b1-b9d2-46a314d6a97f@redhat.com>
Date: Fri, 11 Jul 2025 10:53:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] nvme-multipath: queue-depth support for marginal
 paths
To: Muneendra Kumar <muneendra.kumar@broadcom.com>, bgurney@redhat.com
Cc: axboe@kernel.dk, dick.kennedy@broadcom.com, hare@suse.de, hch@lst.de,
 james.smart@broadcom.com, kbusch@kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, njavali@marvell.com, sagi@grimberg.me,
 muneendra737@gmail.com
References: <20250624202020.42612-1-bgurney@redhat.com>
 <20250711025925.1831977-1-muneendra.kumar@broadcom.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250711025925.1831977-1-muneendra.kumar@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250711_075336_589636_13FFF07E 
X-CRM114-Status: GOOD (  13.29  )
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


On 7/10/25 10:59 PM, Muneendra Kumar wrote:
> Correct me if iam wrong.
>>> . In the case where
>>> all paths are marginal and no optimized or non-optimized path is
>>> found, we fall back to __nvme_find_path which selects the best marginal path
> 
> With the current patch __nvme_find_path will allways picks the path from non-optimized path ?

Not necessarily. I think it all comes down the this code:

                switch (ns->ana_state) {
                 case NVME_ANA_OPTIMIZED:
                         if (!nvme_ctrl_is_marginal(ns->ctrl)) {
                                 if (distance < found_distance) {
                                         found_distance = distance;
                                         found = ns;
                                 }
                                 break;
                         }
                         fallthrough;
                 case NVME_ANA_NONOPTIMIZED:
                         if (distance < fallback_distance) {
                                 fallback_distance = distance;
                                 fallback = ns;
                         }
                         break;

Any NVME_ANA_OPTIMIZED path that is marginal becomes a part of the fallback ns algorithm.

In the case where there is at least one NVME_ANA_OPTIMIZED path, it works correctly.  You will always find the NVME_ANA_OPTIMIZED
path.  In the case there there are no NVME_ANA_OPTIMIZED paths it turns in to kind of a crap shoot. You end up with the first fallback
ns that's found.  That could be an NVME_ANA_OPTIMIZED path or an NVME_ANA_NONOPTIMIZED path.  It all depends upon how the head->list is
sorted and if there are any disabled paths.

In our testing I've seen that this sometimes selects the NVME_ANA_OPTIMIZED path and sometimes the NVME_ANA_NONOPTIMIZED path.

In the simple test case, when the first two paths are optimized, and only one is marginal, this algorithm always selects the NVME_ANA_NONOPTIMIZED path.

It's only the more complicated test when all NVME_ANA_NONOPTIMIZED paths are marginal that I see some unpredictability.

/John




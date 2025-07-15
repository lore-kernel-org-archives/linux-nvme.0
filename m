Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E804C83F22
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 19:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zkY7jaGGEMaqb4h0ytVqk5X4FiTk2+djHhAkhMNzR/E=; b=W2hoWy4ki7H6JV4Vx1pMdNDrqR
	7APe724blrO6eJ/l648EnxzRHiLsILlLmn4eJQor65GrwXYgKjwv7IWT2NXAzpIDxemMTbFf4UAhQ
	EHc5COoO5vXnb8kzX9ufeoIIxKI84QFmTMNi3T18vlTEFV5OjSfOtqxq+vo//G8htSsJgsqHGb5UL
	36H8TdVp9dzxsdV5PQHCOhnqSR4MCa9T5pERjH5awBTjnqSFINFHOWhDzkSAh/PHoPShanWYhOLfr
	lLFY+9SP1rq0qlGngSJFZuRiTk3L8+eOlgOTa3tr4WjwOzgwXDiVWMr1DAoAGO2F1iMr8g2PZiOMo
	5l9xQLOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ublY4-000000066kj-1Bcz;
	Tue, 15 Jul 2025 19:42:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ublY1-000000066k7-0WHM
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 19:42:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752608559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkY7jaGGEMaqb4h0ytVqk5X4FiTk2+djHhAkhMNzR/E=;
	b=iJ/n5ts0ZsNvlwDsiNhrxj2lWMam+dy377XT0UnicSbvmw9jGuAwboCn4FFgPUZRDgX/W0
	6ol0KsF8LzHDa/ctl+5oc2aSsYMfEDHGAUc5aNOiZI4e/ntdQBtwkUGPmhCe0J4OQBaR5k
	DVW9IrsVSWUmni1sDhPDP9oYi5tUxzU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-KbK-_ZNlN86KYo4VSBO_pg-1; Tue,
 15 Jul 2025 15:42:38 -0400
X-MC-Unique: KbK-_ZNlN86KYo4VSBO_pg-1
X-Mimecast-MFC-AGG-ID: KbK-_ZNlN86KYo4VSBO_pg_1752608556
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F30218002AA;
	Tue, 15 Jul 2025 19:42:36 +0000 (UTC)
Received: from [10.22.88.94] (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1C7018002B1;
	Tue, 15 Jul 2025 19:42:33 +0000 (UTC)
Message-ID: <35738598-0733-408c-8597-20c3599a8973@redhat.com>
Date: Tue, 15 Jul 2025 15:42:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/8] nvme: sysfs: emit the marginal path state in
 show_state()
To: Keith Busch <kbusch@kernel.org>, Bryan Gurney <bgurney@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 axboe@kernel.dk, james.smart@broadcom.com, dick.kennedy@broadcom.com,
 njavali@marvell.com, linux-scsi@vger.kernel.org, hare@suse.de
References: <20250709211919.49100-1-bgurney@redhat.com>
 <20250709211919.49100-8-bgurney@redhat.com> <aG7pSA6TOAANYrru@kbusch-mbp>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <aG7pSA6TOAANYrru@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_124241_239781_1EBAD62C 
X-CRM114-Status: GOOD (  15.07  )
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

On 7/9/25 6:12 PM, Keith Busch wrote:
> On Wed, Jul 09, 2025 at 05:19:18PM -0400, Bryan Gurney wrote:
>> If a controller has received a link integrity or congestion event, and
>> has the NVME_CTRL_MARGINAL flag set, emit "marginal" in the state
>> instead of "live", to identify the marginal paths.
> 
> IMO, this attribute looks more aligned to report in the ana_state
> instead of overriding the controller's state.
> 

We can't really do this because the ANA state is a documented protocol state.

The linux controller state is purely a linux software defined state.  Unless I am wrong, there is nothing in the NVMe specification which defines the nvme_ctrl_state.

This is purely a linux definition and we should be able to change is any way we want.

We debated adding a new NVME_CTRL_MARGINAL state to this data structure,

enum nvme_ctrl_state {
         NVME_CTRL_NEW,
         NVME_CTRL_LIVE,
         NVME_CTRL_RESETTING,
         NVME_CTRL_CONNECTING,
         NVME_CTRL_DELETING,
         NVME_CTRL_DELETING_NOIO,
         NVME_CTRL_DEAD,
};

If you don't like the flag we can do that. However, that doesn't seem worth the effort since Hannes has this working now with a flag.

/John



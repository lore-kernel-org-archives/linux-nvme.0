Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8257ECAC5AC
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Sep 2025 19:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xl7UyYqk9Vb6Zxi8T4sES16fmcCIjyttGOTxSZhU4nY=; b=ccxT7snT/GRlHELZgdNv5h5qOD
	3lZst5V59w9yKe51Be2GEoGQOwhzL4vGDdLqVcQQYBE/b/9XoG9K2PkSrJaNvK4mSPCpx5e23vNcz
	tnZQNhvuWQIeYvsTUV91PILj6Qkl+FXBWrV7hsY7kVzUNPIkgnsilfJp6D8yVWLY7JQ51S0t9HLs6
	Wf01CLL7pg0l0lHQTxp+BpIr1ykmUwxZeG6j6G3FQFGQ2l7bc1q1Kx0wZ4dCrP+PSC0sPCqIx5pzm
	USWmSX0+nmVgcNA9PECFNXUKgYBwYtC+WZj814kC9zG630uCebN1ZwFdrZWJ8loQTm85azvBc7fuA
	bdRoeuSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v18aA-0000000EejE-1Sff;
	Tue, 23 Sep 2025 19:21:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v18a7-0000000EeiH-1pf8
	for linux-nvme@lists.infradead.org;
	Tue, 23 Sep 2025 19:21:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758655301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xl7UyYqk9Vb6Zxi8T4sES16fmcCIjyttGOTxSZhU4nY=;
	b=aEXCHszLeQEVqJdjuuxlij1vmZEP9rw3FzZxy1gVAAIu0r5DJvXHPv7GZNIjRaU3nJu8eD
	esfsYELk8DWOmYqMJg8hfTvLC9Ln/RzdStByR7N+YGs9QnFGTaaWMmC1GCETc+mFU3eMNS
	Zu6ArwVvHwNeCjcJ0JIh615G1O9Ga/0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-8HdHTSfQMHOU2C0oO_HfiQ-1; Tue,
 23 Sep 2025 15:21:34 -0400
X-MC-Unique: 8HdHTSfQMHOU2C0oO_HfiQ-1
X-Mimecast-MFC-AGG-ID: 8HdHTSfQMHOU2C0oO_HfiQ_1758655292
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70CCA195608A;
	Tue, 23 Sep 2025 19:21:32 +0000 (UTC)
Received: from [10.22.81.200] (unknown [10.22.81.200])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE10D18003FC;
	Tue, 23 Sep 2025 19:21:28 +0000 (UTC)
Message-ID: <513ae24d-fe17-4dd1-a226-4c699e94c0e3@redhat.com>
Date: Tue, 23 Sep 2025 15:21:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v9 0/8] nvme-fc: FPIN link integrity handling
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk, Bryan Gurney <bgurney@redhat.com>
Cc: james.smart@broadcom.com, njavali@marvell.com,
 linux-scsi@vger.kernel.org, hare@suse.de, linux-hardening@vger.kernel.org,
 kees@kernel.org, gustavoars@kernel.org, emilne@redhat.com
References: <20250813200744.17975-1-bgurney@redhat.com>
 <175613417235.1984137.13827666752970522478.b4-ty@oracle.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <175613417235.1984137.13827666752970522478.b4-ty@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_122143_547915_0DA2FB22 
X-CRM114-Status: GOOD (  17.77  )
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

Hey Martin.

We've been testing this patch and it turns out there is a significant bug here.

This bug causes a call trace and a driver hang.

I suggest you remove this from scsi-queue and let us fix it.

/John

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 253f802605d6..44e9f7df8db2 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -6459,9 +6459,10 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha,
  void
  qla24xx_free_purex_item(struct purex_item *item)
  {
-       if (item == &item->vha->default_item) {
-               memset(&item->vha->default_item, 0, sizeof(struct purex_item));
-               memset(&item->vha->__default_item_iocb, 0, QLA_DEFAULT_PAYLOAD_SIZE);
+       scsi_qla_host_t *base_vha = item->vha;
+       if (item == &base_vha->default_item) {
+               memset(&base_vha->__default_item_iocb, 0, QLA_DEFAULT_PAYLOAD_SIZE);
+               memset(&base_vha->default_item, 0, sizeof(struct purex_item));
         } else
                 kfree(item);
  }


On 8/25/25 10:33 PM, Martin K. Petersen wrote:
> On Wed, 13 Aug 2025 16:07:35 -0400, Bryan Gurney wrote:
> 
>> FPIN LI (link integrity) messages are received when the attached
>> fabric detects hardware errors. In response to these messages I/O
>> should be directed away from the affected ports, and only used
>> if the 'optimized' paths are unavailable.
>> Upon port reset the paths should be put back in service as the
>> affected hardware might have been replaced.
>> This patch adds a new controller flag 'NVME_CTRL_MARGINAL'
>> which will be checked during multipath path selection, causing the
>> path to be skipped when checking for 'optimized' paths. If no
>> optimized paths are available the 'marginal' paths are considered
>> for path selection alongside the 'non-optimized' paths.
>> It also introduces a new nvme-fc callback 'nvme_fc_fpin_rcv()' to
>> evaluate the FPIN LI TLV payload and set the 'marginal' state on
>> all affected rports.
>>
>> [...]
> 
> Applied to 6.18/scsi-queue, thanks!
> 
> [9/9] scsi: qla2xxx: Fix memcpy field-spanning write issue
>        https://git.kernel.org/mkp/scsi/c/6f4b10226b6b
> 



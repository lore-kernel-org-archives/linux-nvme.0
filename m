Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852BDC021AA
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 14:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rMrruAE5SiJm5VJDlkLG+tKoURFhiL1O+/bcGgjwo1Y=; b=TO9CmECeQJtpGXfI4Ls+DRzxA4
	5fwWvRK8NgcpjKNjfRy4EECHol/SNiUkbfkEG/bxmGxN+80TYoOocws5JZsfUTP5xRz1TwyfPhdOi
	zOfOfs/gqu1JUypeFptHymczzbgt74sUUWzPDkCiW+o8Z+Fw73MzPqjK/gTT2DNyut6ncKA8neD6c
	MY4kt9H2M8r9T8W63y/zn6LULCUvSlBClbi9Gr3DznR5gWeJsrxetSYISaT91M3p0Xw81lcy4Q2cO
	aMS0PMwxkWTaay+8+YF6ZxCc8nNL5n6+EKQ6zqjW9BekSRyvHZcAUvk1yfy1drupe3mnr1jbHubtA
	GIQn6UTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkOHg-00000008RRq-1X2y;
	Tue, 18 Feb 2025 14:09:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkOEZ-00000008Qmb-43P6
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 14:06:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739887559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMrruAE5SiJm5VJDlkLG+tKoURFhiL1O+/bcGgjwo1Y=;
	b=bkwuZhVHW7JPHlf9X9ARR5YI/CI6FmR213QJgPon32hC38eVCJt42u7nVeYg+NcdeUI59+
	ycWHsgt4XVMboYubfeuZQ1sobjLVS5BLHz7rXD/GQ3+b/EIQUTTBJXUqGz0gq+RXLxoy6a
	3FaMWEj0O2UgBcxJRLYL/tLIdAlVMAs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-EAQOEwS3P0aUyqi_ol7Jsw-1; Tue,
 18 Feb 2025 09:05:55 -0500
X-MC-Unique: EAQOEwS3P0aUyqi_ol7Jsw-1
X-Mimecast-MFC-AGG-ID: EAQOEwS3P0aUyqi_ol7Jsw_1739887554
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC1DB1866D90;
	Tue, 18 Feb 2025 14:05:40 +0000 (UTC)
Received: from [10.22.65.116] (unknown [10.22.65.116])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45BE31956094;
	Tue, 18 Feb 2025 14:05:38 +0000 (UTC)
Message-ID: <87850a70-4a93-492f-a6b5-fec5d5480cf4@redhat.com>
Date: Tue, 18 Feb 2025 09:05:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, hch@lst.de
Cc: bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <ea0e6445-9770-4df9-91bd-80f44cd0388e@grimberg.me>
 <ea9537d5-721a-4b37-84d1-df797646fce2@redhat.com>
 <ccc171d1-8de3-4632-9483-71fd5ea63d46@grimberg.me>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <ccc171d1-8de3-4632-9483-71fd5ea63d46@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_060601_953272_F4301EAA 
X-CRM114-Status: GOOD (  13.85  )
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

On 2/18/25 3:19 AM, Sagi Grimberg wrote:
>> We can send send a separate patch to address that problem, but this patch, which simply removes the nvme_core.multipath parameter
>> has beeen fully tested and is ready to go.
> 
> I think that we want to print a warning in this case though. Can you resubmit with logging a warning in this case?

Agreed, but I was thinking that warning should go into the second patch. The second patch should disable all secondary paths when
CONFIG_NVME_MULTPATH=N and a namespace is discovered with NMIC enabled. Basically, we don't want to instantiate more than one
namespace when CONFIG_NVME_MULTPATH=N.

But if you want to add a warning to this patch, we could do something like this:

@@ -3909,16 +3909,23 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
                 disk->flags |= GENHD_FL_HIDDEN;
         } else {
  #ifdef CONFIG_NVME_MULTIPATH
                 sprintf(disk->disk_name, "nvme%dn%d", ctrl->subsys->instance,
                         ns->head->instance);
  #else
                 sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
                         ns->head->instance);
+               if (info->is_shared) {
+                       dev_warn(ctrl->device,
+                               "Found shared namespace %d but multipathing not supported.\n",
+                               info->nsid);
+                       dev_warn_one(ctrl->device,
+                               "Shared namepaces without CONFIG_NVME_MULTIPATH=Y is not supported.\n")
+               }
  #endif
         }

         if (nvme_update_ns_info(ns, info))
                 goto out_unlink_ns;




Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B47C021AA
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PQ2shq+Ea+M+HlSyRdqdGGltGsI+k+k+AJworNHVRfc=; b=Qv597skVEkzjOdS7b2u//Gy4dR
	kYPRhtxNxpWR5C1g/PeedMsxvqm+7NCR18ektskuotHD4KHNgKJP/aiv34ItrSZ+PhcEE9/X8LdHF
	6YOVYe7dGULL7aYbRDFmiQ2cLQFBg8mQfN/qkvnV0s5xczckloUDxG9QFZJBDPFMDPGUhWKWEEPx+
	bDptOP2OzU342T9SLCP5koM/LNRMa86k/rLh0JUjEoLEiWT9hCS42PLWNq4RymLl76gp+hHskGSgO
	K8Lk1EYe/QguzE+yz3AvDGlUTN61xQiEvRDHl4MzefEOVAU3TxV3fxSBV/WQz6QF0KIWehr3Y5yp4
	r1/bPyww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkQhU-000000091Dv-1KoM;
	Tue, 18 Feb 2025 16:44:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkQfe-000000090wE-00sD
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 16:42:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739896925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQ2shq+Ea+M+HlSyRdqdGGltGsI+k+k+AJworNHVRfc=;
	b=BCkQJ0t8bvE8ZSnas88b1FaS2Kav5s1xEzJaGa3x0n6pf5Y9e6DISI/T0ACYSZRlL2C8px
	t28wuWkl67AZBHm4qX0oJXycx6qdSyuphph8R+lkY4BJTwoEdD1SxiomS/lFWeBYbw+swK
	UvffxN+3voxsezWx+Je5eKUP54JgNsA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-ow03Jz9gPGSG0iTbSluz0Q-1; Tue,
 18 Feb 2025 11:42:01 -0500
X-MC-Unique: ow03Jz9gPGSG0iTbSluz0Q-1
X-Mimecast-MFC-AGG-ID: ow03Jz9gPGSG0iTbSluz0Q_1739896920
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E62271800875;
	Tue, 18 Feb 2025 16:41:59 +0000 (UTC)
Received: from [10.22.65.116] (unknown [10.22.65.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D040819560A3;
	Tue, 18 Feb 2025 16:41:57 +0000 (UTC)
Message-ID: <03bd60e5-7c7b-4589-a71a-a48ff53a619c@redhat.com>
Date: Tue, 18 Feb 2025 11:41:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
From: John Meneghini <jmeneghi@redhat.com>
To: Bryan Gurney <bgurney@redhat.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk
Cc: bmarzins@redhat.com
References: <20250204211158.43126-1-bgurney@redhat.com>
 <b37a4f6c-95a9-430d-89f9-141b72fd6be8@redhat.com>
Content-Language: en-US
Organization: RHEL Core Storge Team
In-Reply-To: <b37a4f6c-95a9-430d-89f9-141b72fd6be8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_084206_115096_B5B46CD8 
X-CRM114-Status: GOOD (  11.05  )
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

On 2/18/25 9:26 AM, John Meneghini wrote:
>> +    } else {
>> +#ifdef CONFIG_NVME_MULTIPATH
>>           sprintf(disk->disk_name, "nvme%dn%d", ctrl->subsys->instance,
>>               ns->head->instance);
>> -    } else {
>  > +#else
> 
> You don't need the this #ifdef conditional statement because the nvme_ns_head_multipath() function checks CONFIG_NVME_MULTIPATH
> for you and the sprintf(disk->disk_name, "nvme%dn%d" statement is kind of redundant.
> 
> 
>>           sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
>>               ns->head->instance);
>> +#endif 

Actually, I think I may be wrong about this.  To maintain 100% backward compatibility with what the users see in the dmesg log, I think we need this code.

/John



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FCBC021A9
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 17:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z6/+vP1Xpq+4H3W/cSS/0CX+mScp7vF8v6bogSAvR/s=; b=gUQGN5IbotEV8Sb9ffe+BZHaHa
	K5VkL2u3CVZEW4sKAFUgPM9+SM0j7P2rkW9H2WDZyzm6gq1MHUpROJvV5HRuQj6Byb8fLfHDC83LT
	kuTyLNltaBwRmRr+cq8pGUIXduGto8WMi4sA4z0lQtDPNZotGdDXjwd3xMQjWClgFWHjcwjAXv//T
	4ALi6xGSleC38oIc4hJ1JHZEQhclSfj+K5kRYnh3j16y3SO8De7e6/LsEUj4QF1cnyDFTM0RQ2o/E
	P1nnMETdLymLaajBVhvZt3dg3upD9OR91G6hSHHiSvcsGZKiml3owBeGAaX3HAonnwGqycWAV5jRc
	iatjF+ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tk4q7-00000005RGX-1pVT;
	Mon, 17 Feb 2025 17:23:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tk3ln-00000005E4J-3oz4
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 16:14:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739808894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6/+vP1Xpq+4H3W/cSS/0CX+mScp7vF8v6bogSAvR/s=;
	b=Vo0mxhPD5KXAlWncBrVCzeJJ07nxGeYcAWPSc3FglG7n+J43jYuYSn+jb9CUcSjjOFQnrn
	yeigLi5emC7dRn3lXe5xcleYbEEJWAZ8PvyZ7KyrgY2FiO5pxoASHRI2BciZ6mm2TIC9X4
	XHHsSh3K66sWJp9R80G0t2JZm4Yqutk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-SAEJScF1P7isgQ0EHNNT0g-1; Mon,
 17 Feb 2025 11:14:51 -0500
X-MC-Unique: SAEJScF1P7isgQ0EHNNT0g-1
X-Mimecast-MFC-AGG-ID: SAEJScF1P7isgQ0EHNNT0g_1739808889
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94E9F19783B5;
	Mon, 17 Feb 2025 16:14:48 +0000 (UTC)
Received: from [10.22.65.116] (unknown [10.22.65.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20C561955BCB;
	Mon, 17 Feb 2025 16:14:44 +0000 (UTC)
Message-ID: <ea9537d5-721a-4b37-84d1-df797646fce2@redhat.com>
Date: Mon, 17 Feb 2025 11:14:44 -0500
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
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <ea0e6445-9770-4df9-91bd-80f44cd0388e@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250217_081456_019187_59D7E7A5 
X-CRM114-Status: GOOD (  12.07  )
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


On 2/17/25 3:08 AM, Sagi Grimberg wrote:
>>
>> We plan to ship this patch with RHEL-10. So it would be really good if we could get this
>> change accepted and merged upstream, perhaps into v6.15.
> 
> Hey John,
> 
> This looks fine to me, I'm assuming this was also tested with CONFIG_NVME_MULTIPATH=n ?

Yes, everything has been tested with CONFIG_NVME_MULTIPATH both enabled (Y) and disabled (N).

As we discussed in the previous email thread[1] there is an anomaly seen when you build a kernel with CONFIG_NVME_MULTIPATH=n.
and the host discovers a multipath capable nvme device (CMIC/NMIC=1). You will see exactly the same thing that you do with
CONFIG_NVME_MULTIPATH=y when the nvme_core.multipath parameter is N. You see a separate /dev/nvmeNN entry for
every namespace/controller path.

We can send send a separate patch to address that problem, but this patch, which simply removes the nvme_core.multipath parameter
has beeen fully tested and is ready to go.

[1] https://lore.kernel.org/linux-nvme/58519c4e-5801-4481-9087-be4f19b218f7@redhat.com/

Please approve/merge this patch.

/John



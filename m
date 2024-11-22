Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC03E69188
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QwKTTx7s6LOt9fOonERQ/U8O+1ezUV/XX92FI19YTLY=; b=2XlWhPqURguhlhrvOcoZmC7hFl
	zajWIhFC6jRWxBMOa03YRJdh5MIxFcDE/ITGH6udsFqqYmfFbLl8vLv0AEP1FWMjNVDP7JA30QdV1
	RkICBVLEGWCDmOt80NcCsUbsbZhz/ppZ6g0NnV6HvBoPRdx+Wv43tJSrCAh4HNlSz3FgoAz0E6hBX
	5H7YXIRRlnLELDxtGcY/hSkSK02H5UDq2puLOgBACS33XM8rxmxX1sGM4kPvQfg/rZAhJ0noIkVzA
	r56p0N8+BnNebIbf+VFUYQE1UYWng+uuUQQRx/eebG00d06jQRtSvy/gGOW5VfoDeybC+6gpMMhc3
	KsqaUWqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEYPx-000000037JG-24oA;
	Fri, 22 Nov 2024 18:30:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEYPu-000000037Is-1kZF
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 18:30:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732300205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwKTTx7s6LOt9fOonERQ/U8O+1ezUV/XX92FI19YTLY=;
	b=QJg2/6Qj9Cikmk6juOu9Ax91eQM3Kk/lukHE3n7vggSMFyipRREZ/S+WnTEyBpXPr0hPIy
	BRL9/W1IYDJLizuvKWEn4uo8da7JfB+sL0LUFlBHfVBLlNMBlFyMAOpfDiZxFq9C17sfkp
	uoQBMedKpjdCwWJiou91zMis9om9rf4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-g5FeemTZM_WoU0ASHWgwjQ-1; Fri,
 22 Nov 2024 13:30:03 -0500
X-MC-Unique: g5FeemTZM_WoU0ASHWgwjQ-1
X-Mimecast-MFC-AGG-ID: g5FeemTZM_WoU0ASHWgwjQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB3AA1955E87;
	Fri, 22 Nov 2024 18:30:01 +0000 (UTC)
Received: from [10.22.81.129] (unknown [10.22.81.129])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E01D11955F3E;
	Fri, 22 Nov 2024 18:29:58 +0000 (UTC)
Message-ID: <58519c4e-5801-4481-9087-be4f19b218f7@redhat.com>
Date: Fri, 22 Nov 2024 13:29:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: always enable multipath
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Bryan Gurney <bgurney@redhat.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, axboe@kernel.dk, mpe@ellerman.id.au, naveen@kernel.org,
 maddy@linux.ibm.com, kernel@xen0n.name, bmarzins@redhat.com
References: <20241121220321.40616-1-bgurney@redhat.com>
 <20241122120925.GA25817@lst.de>
 <Z0ClxgBJG_YBF-Ql@kbusch-mbp.dhcp.thefacebook.com>
 <a6902168-0a8e-43ff-afef-b100f75d266c@redhat.com>
 <Z0DKJWjtrpuy8j_V@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <Z0DKJWjtrpuy8j_V@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_103006_533327_71FA645B 
X-CRM114-Status: UNSURE (   8.14  )
X-CRM114-Notice: Please train this message.
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

On 11/22/24 13:15, Keith Busch wrote:> If you want to change the driver to prevent exposing subsequent
> namepsace path block devices when multipath is not enabled, that is
> probably fine.

OK, we'll work on another patch to do this. The plan will be:

When CONFIG_NVME_MULTIPATH=y, you get multipath.c and full support for both nvme multipath (CMIC/NMIC = 1) and non-multipath 
devices (CMIC/NMIC=0) devices with 1 /dev entry per namespace.

When CONFIG_NVME_MULTIPATH=n, you get support for non-multipath devices (CMIC/NMIC=0) devices, but multipath devices 
(CMIC/NMIC=1) will only expose the first controller/namespace path.

/John



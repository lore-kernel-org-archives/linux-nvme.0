Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CB6C02198
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 14:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x+4AZod0zwwoKSkEdpQmvjuKbyYTyP5Z7/IeKW01Ztg=; b=ILNIxrZLijgmBnWUObqy7kfNbj
	j+5ZqpK+nNhg/aomis6j9kXOjFVGn4I08hIqZzfPOeDfSuKuQ/Vdxjc0CKY/swenU35AljStos6GF
	OREdXVa9hv54X683dv68FXc+N/sk3NNsgZeSH8e0IIhknIEUwYPaBbPlu9LqlyAcFwyWDI/CoMGKj
	SYwZAyie3W8p+SiNpOlkU02glm5HFC541/NOsJCp0uABK6RcvYyT+VIe7/acnuNmaShE3LhJt6qNA
	G1x4FJMqVJQRp79ydDvqQ6oMazrGew47LEwQCBimGjHW8gk8Ow94ffZQ+RhfAxc26KCVC1DxXosJq
	UplZY1cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkP4R-00000008f6K-33Tb;
	Tue, 18 Feb 2025 14:59:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkP2F-00000008eX1-3qI8
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 14:57:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739890639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+4AZod0zwwoKSkEdpQmvjuKbyYTyP5Z7/IeKW01Ztg=;
	b=Abvx6xLIevjBwIpiS6g0IZjrsAprmpV511L+TMYmYlZOYBVMXd1smImGljpEXeJX17iDe4
	nmK3OXrE2gROYoZr3vfE0uCqH/0tcwg1f+dHDO0YU0r7c5+sV2d67MlqpzHz9yTulEmQuB
	x4O3kT5EDzjZWclEFYw+DBJZniyYcI0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-bkK2-au8O8CFbsTrdqMeEA-1; Tue,
 18 Feb 2025 09:57:15 -0500
X-MC-Unique: bkK2-au8O8CFbsTrdqMeEA-1
X-Mimecast-MFC-AGG-ID: bkK2-au8O8CFbsTrdqMeEA_1739890634
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43EE418EB2C9;
	Tue, 18 Feb 2025 14:57:14 +0000 (UTC)
Received: from [10.22.65.116] (unknown [10.22.65.116])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 121BE1956094;
	Tue, 18 Feb 2025 14:57:11 +0000 (UTC)
Message-ID: <efbab2b8-7723-46ee-a296-7e76bdaedc2c@redhat.com>
Date: Tue, 18 Feb 2025 09:57:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
From: John Meneghini <jmeneghi@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, hch@lst.de
Cc: bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <ea0e6445-9770-4df9-91bd-80f44cd0388e@grimberg.me>
 <ea9537d5-721a-4b37-84d1-df797646fce2@redhat.com>
 <ccc171d1-8de3-4632-9483-71fd5ea63d46@grimberg.me>
 <87850a70-4a93-492f-a6b5-fec5d5480cf4@redhat.com>
Content-Language: en-US
Organization: RHEL Core Storge Team
In-Reply-To: <87850a70-4a93-492f-a6b5-fec5d5480cf4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_065720_041654_806ABE4F 
X-CRM114-Status: UNSURE (   8.12  )
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

On 2/18/25 9:05 AM, John Meneghini wrote:
> +               if (info->is_shared) {
> +                       dev_warn(ctrl->device,
> +                               "Found shared namespace %d but multipathing not supported.\n",
> +                               info->nsid);

Or maybe this should be

+               if ((ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) && info->is_shared) {
+                       dev_warn(ctrl->device,
+                               "Found shared namespace %d but multipathing not supported.\n",
+                               info->nsid);

/John




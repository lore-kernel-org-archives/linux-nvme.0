Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB5FC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jan 2022 17:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xX77UtRP3FiINom2HH8xWsxroLFr1AI6KNWbCLQZdOA=; b=UukG48pHu7TAuN8LFD/sNeV2dv
	p0mH/+HI5XSwnzEjt40cZQvPrFhubVlW9vEhVd6KKAsMiRBb8EsKLKVLHH5v/jBSSOhdSLdIzJEGU
	e2X2Bkw7yDRbLc0osEhiGSEAIhllTIZMcRXvSR5vDKz9nDSRMo9+DjhLLQTSY6gw9zGqA35nTjlBY
	JfAUMSOD5PDYUFhEGIfc66m0PaZxRJHsZjPKenZIbf8ky0qJYw+Y+hu7GNTPDbVghFnnGULE4pmb3
	rU5OGQePrBGuAhLWXsHcNunBbXoY+hclGxDoMBzUlHQZ7ffQ8hycCey7rTdQvfAqDPf5W552wHoPz
	pWhHuIlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEaQG-00A5ws-Rc; Mon, 31 Jan 2022 17:25:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEa6l-009zSR-BA
 for linux-nvme@lists.infradead.org; Mon, 31 Jan 2022 17:04:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643648689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xX77UtRP3FiINom2HH8xWsxroLFr1AI6KNWbCLQZdOA=;
 b=YHFUyGe7eNZ/x4guSKCVomNSVJOqvMnEBzYcy/hIbpQKQD/wyOIX9vIc4r63H8HgJTr780
 7TqBWhP8lH2liZhQZ5ACbbCO52gsyT2Si64qRwD5cYqL28pFl62DgQcPQEspexOT8rUqZz
 DmoKPnluMLDuoyTgQs27TQj+We3IgkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-pZQJe3rJMzO_0X6idLAz9g-1; Mon, 31 Jan 2022 12:03:06 -0500
X-MC-Unique: pZQJe3rJMzO_0X6idLAz9g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFDE11083F60;
 Mon, 31 Jan 2022 17:03:04 +0000 (UTC)
Received: from [10.22.34.217] (unknown [10.22.34.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0065D8379E;
 Mon, 31 Jan 2022 17:03:03 +0000 (UTC)
Message-ID: <047b496c-e3a4-bcaa-c542-3f933ed8d54a@redhat.com>
Date: Mon, 31 Jan 2022 12:03:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] nvme-fabrics: add tp8010 support
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, Martin Belanger <martin.belanger@dell.com>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291A94BED970C6599BBC6679C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <BL0PR13MB4291A94BED970C6599BBC6679C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220131_090451_547152_65B03C65 
X-CRM114-Status: GOOD (  15.08  )
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

Hi Martin.

Properly speaking, registrations are sent to the CDC, not the DC.

Correct?

Can we please change this, everywhere, to be clear about when we are "talking" to the CDC (Centralized Discovery Controller) and 
when we are talking to the DC (Discovery Controller).

/John

On 1/25/22 09:59, Martin Belanger wrote:
> +/**
> + * nvme_get_adrfam() - Get address family for the address we're registering
> + * with the DC. We retrieve this info from the socket itself. If we can't
> + * get the source address from the socket, then we'll infer the address
> + * family from the address of the DC since the DC address has the same
> + * address family.
> + *
> + * @ctrl: Host NVMe controller instance maintaining the admin queue used to
> + *      submit the DIM command to the DC.
> + *
> + * Return: The address family of the source address associated with the
> + * socket connected to the DC.



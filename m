Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA44C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jan 2022 18:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4qJeaqrRf778wq2BQfFKUV1OWDWmQIwyTuVLNNRro94=; b=181dFG0WsA9vwq1zvEz1rrNisi
	nk9+QjZ7BgtWh2cwRz8WYI1tjxBasyBsPWJXVw/qc2Eu+lZuZ0DG6bB7BiK+SMYwY94SuhtjmfGPR
	n02dDdy1qU3q1phELakEA1wEOGCBs4JlUk6gJxHk6H1MpgMySokFpzw0+5UUIs4SD3CnsOl+z5813
	PgHfW2ADffGfS42KYzuI5pmImLl0Fdkd259x3U/9Vq5MV2kkx+S8DKoG0DS+1+uif4URr6GPTJ8xk
	sWjOFj6/RdOTKF3fPJpNWabIl32HNuLYQ6+1MfhXbVvXfp44BqyiLRm94E1kx0oKRpeSyCMxaH7bg
	ogVnhWjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEbPy-00ALsq-V1; Mon, 31 Jan 2022 18:28:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEbPu-00ALp5-T2
 for linux-nvme@lists.infradead.org; Mon, 31 Jan 2022 18:28:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643653721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4qJeaqrRf778wq2BQfFKUV1OWDWmQIwyTuVLNNRro94=;
 b=HBPrdnEv9KHnJ/HbGgX2rbLV0hRmgdsSkyGEN94UHXsV3S9IxdD/cJKaIfUbmn2F4UNlO3
 1Nk4xY5RoNg7Z0OohmYWUW3Srwz/7rtVz1IJ9olX1LZ/9i8QPsIwfjbZd5VppoBDVL87GU
 TMdCpvIcGAaoVDYJuEze/KCil3OqwRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-Wy9KzFqwMCmSJdiqOhEvxQ-1; Mon, 31 Jan 2022 13:28:36 -0500
X-MC-Unique: Wy9KzFqwMCmSJdiqOhEvxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EDE71091DA1;
 Mon, 31 Jan 2022 18:28:35 +0000 (UTC)
Received: from [10.22.34.217] (unknown [10.22.34.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35F407D48A;
 Mon, 31 Jan 2022 18:28:34 +0000 (UTC)
Message-ID: <e0d6afc7-a11a-3fe2-5f0d-fe17bb8f3f8a@redhat.com>
Date: Mon, 31 Jan 2022 13:28:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] nvme-fabrics: add tp8010 support
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291A94BED970C6599BBC6679C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <047b496c-e3a4-bcaa-c542-3f933ed8d54a@redhat.com>
 <SJ0PR19MB454431C4643E2CB5C0BB45C1F2259@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <SJ0PR19MB454431C4643E2CB5C0BB45C1F2259@SJ0PR19MB4544.namprd19.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220131_102843_053724_6663236F 
X-CRM114-Status: GOOD (  21.16  )
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

OK. Thanks Martin.  That explains it.

On 1/31/22 12:17, Belanger, Martin wrote:
>> Hi Martin.
>>
>> Properly speaking, registrations are sent to the CDC, not the DC.
>>
>> Correct?
>>
>> Can we please change this, everywhere, to be clear about when we are
>> "talking" to the CDC (Centralized Discovery Controller) and when we are
>> talking to the DC (Discovery Controller).
>>
>> /John
> 
> Hi John.
> 
> TP8010 originally intended for registration (DIM PDU) to be sent
> to CDCs only. However, this was changed to include Direct Discovery
> Controllers (DDC)  as well. That's why I use DC and not CDC.
> 
> Also note that TP8010 introduces a new DCTYPE field in the response to
> the Identify command, which is used to differentiate between a CDC and
> a DDC. Legacy DCs that do not comply to TP8010 will have DCTYPE=0
> (i.e. Discovery controller type is not reported). So, registration will not
> be attempted  for DCTYPE other than 1 (DDC) and 2 (CDC).
> 
> Here you will find the ratified version of TP8010:
> https://nvmexpress.org/wp-content/uploads/NVM-Express-2.0-Ratified-TPs-01242022.zip
> 
> Martin
> 
>>
>> On 1/25/22 09:59, Martin Belanger wrote:
>>> +/**
>>> + * nvme_get_adrfam() - Get address family for the address we're
>>> +registering
>>> + * with the DC. We retrieve this info from the socket itself. If we
>>> +can't
>>> + * get the source address from the socket, then we'll infer the
>>> +address
>>> + * family from the address of the DC since the DC address has the
>>> +same
>>> + * address family.
>>> + *
>>> + * @ctrl: Host NVMe controller instance maintaining the admin queue
>> used to
>>> + *      submit the DIM command to the DC.
>>> + *
>>> + * Return: The address family of the source address associated with
>>> +the
>>> + * socket connected to the DC.
> 
> 
> Internal Use - Confidential



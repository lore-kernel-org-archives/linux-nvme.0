Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37388C3ABC3
	for <linux-nvme@archiver.kernel.org>; Mon, 12 May 2025 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ANNF/u2Kv0CTun1y/BS8zIiadDL7Eh4iRMumVU1kpL0=; b=q9N9fhOjEScAHWTJjiCJP098LR
	OE60TnvRI4H59NI9liJqhuq90Q+XWiWAU8f8jBfDy6NF623lTz9nRLJCpTt1pEBR00iJx9Qx7i5Io
	vZ6dUyNLWPMzC1ZgA/bl0cuCd8+KCGLR4sjBxn8RfubCapfXCtHnSk+SW9KtMYBngZDkCQvhljCIK
	QHWmAjpauthxZOIa5dDJNckaqwMje1k6MeLYWH3i0+wtr/3D3WDX9q25DF+4Bed4+QPjrV32cgs7P
	BmrxTT/4VGI1iFu8P59UXJKPLn0JyTrPOmgvpoSaLNxCTUU9GRji79yUvMH1g+oHXPgll9fNaEGUH
	Vl0ocUbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEVJv-00000009vFa-24vL;
	Mon, 12 May 2025 15:43:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEUy6-00000009rAK-2z0J
	for linux-nvme@lists.infradead.org;
	Mon, 12 May 2025 15:21:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747063283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANNF/u2Kv0CTun1y/BS8zIiadDL7Eh4iRMumVU1kpL0=;
	b=ZY+rvSAx93iN2nauHO5rZ6I1V53NFHulTxqU2lNWRZ9xy3fYqxRXX2AUp1+Mhc0LZxUoWF
	VlyRMYd8Nn7QnU3s8nzOI2gQIvV9MYt3p7Mun0Oq6yKUCbnQwWAafxK7V9HKfS9+CT2gF3
	BhIc+V+PQ6Ex/PvTtfs5YxJs5IrXauk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-wRv_x0dRPf2IYC7QsMCKXg-1; Mon,
 12 May 2025 11:19:04 -0400
X-MC-Unique: wRv_x0dRPf2IYC7QsMCKXg-1
X-Mimecast-MFC-AGG-ID: wRv_x0dRPf2IYC7QsMCKXg_1747063143
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1932B1800261;
	Mon, 12 May 2025 15:19:02 +0000 (UTC)
Received: from [10.22.81.0] (unknown [10.22.81.0])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE001195396E;
	Mon, 12 May 2025 15:18:59 +0000 (UTC)
Message-ID: <cec53fce-2f1d-4162-8685-ab7c56649953@redhat.com>
Date: Mon, 12 May 2025 11:18:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: check duplicate unique identifiers in order
To: Keith Busch <kbusch@kernel.org>, Bryan Gurney <bgurney@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 axboe@kernel.dk, mlombard@bsdbackstore.eu
References: <20250509151627.20434-1-bgurney@redhat.com>
 <aB4gO7mAYDO3Bm3A@kbusch-mbp>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <aB4gO7mAYDO3Bm3A@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7C7ZZYuhwh3oQzsg1UBc0Ko6Xk8DDRwBtuzqbp-cy58_1747063143
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250512_082126_835779_4210469F 
X-CRM114-Status: GOOD (  13.33  )
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


On 5/9/25 11:33 AM, Keith Busch wrote:
> On Fri, May 09, 2025 at 11:16:27AM -0400, Bryan Gurney wrote:
>> +	if (has_uuid) {
>> +		list_for_each_entry(h, &subsys->nsheads, entry)
>> +			if (uuid_equal(&ids->uuid, &h->ids.uuid))
>> +				return -EINVAL;
>> +		return 0;
>> +	}
> You're returning success too early here. It may have a unique uuid, but
> that doesn't mean we don't want to check for nguid and eui64 too. 

That's the point of this patch. Once we find a unique id we stop and return before checking the lower precedent IDs.

As it turns out more that one drive reports multiple IDs, but the lower precedent IDs are not unique. We've found this to be
especially true with drives that support namespace management. When you start creating more NSIDs, the drive creates new and
unique NGIUD for each new namepspace, but the EUI64 is duplicated/the same.

> If those are not unique, they need to be blanked out to make sure we don't
> expose these on the namespace's sysfs attributes.

OK, we can add another patch that blanks out the lower precedent/invalid IDs.

Will that work?

/John





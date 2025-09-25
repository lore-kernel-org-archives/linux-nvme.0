Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CC7CAC5A7
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Sep 2025 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NLgbSsFjchtFmvfbazfVlnKhqiQnNP0m9v1472hwd3k=; b=JFQ+fCL/9WfSz7jF1j1mNoZF/k
	3t3sVugEZVJBxo4AT6NaTTmM91TeEXchVgEpco8J/uPJc809xIqC/5Nm/5KkqCUshvAcK4h7PhM/H
	ynd++L2EXb1mIuvdeNVOrfdXE9+7dEu4lPST0T/rmXRNwBlWzANDtr66rBDovz7O7N+J5Sa70ukFZ
	RwnrSSxfgw8T3e0qojMNrDO0Di0hRjP6Ell9VqzmeF9NWdov48zusBab5t7apr9ClgAnIssAgEwxx
	d9v+joC5r4ef60KKlQz4U7nqKj7hzlBoUgkdBxc3Jr1sYL1p24NjcVgp6FECqm10ZZ0REa7+91wm8
	JgY6bNQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1mnh-00000009vo6-2Ju5;
	Thu, 25 Sep 2025 14:18:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1mne-00000009vmQ-0HDA
	for linux-nvme@lists.infradead.org;
	Thu, 25 Sep 2025 14:18:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758809900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLgbSsFjchtFmvfbazfVlnKhqiQnNP0m9v1472hwd3k=;
	b=Pa5NTbpZ6qYHQxVr+IsF/0BHG7CeAGsgd8jtqRuHjPusLG8eRj6Ow2axCHYZhsPgk9qB0/
	c+LsB34ko+GnK6vKR/bWI+LtlIMLaVHN27swNstOrXLfXnAkhoyYD3DF7sc5ZxNyNtsqdP
	om/C/cX8r4Bxjp8anIQsRPzEVS9LOfI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-QamC6vnNMQe10HReUsJafw-1; Thu,
 25 Sep 2025 10:18:19 -0400
X-MC-Unique: QamC6vnNMQe10HReUsJafw-1
X-Mimecast-MFC-AGG-ID: QamC6vnNMQe10HReUsJafw_1758809896
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F3DE19560A0;
	Thu, 25 Sep 2025 14:18:14 +0000 (UTC)
Received: from [10.22.81.200] (unknown [10.22.81.200])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 155871800452;
	Thu, 25 Sep 2025 14:18:09 +0000 (UTC)
Message-ID: <fbbef12e-fc43-464f-b92d-f42f3692a46c@redhat.com>
Date: Thu, 25 Sep 2025 10:18:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "scsi: qla2xxx: Fix memcpy() field-spanning write
 issue"
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, martin.petersen@oracle.com
Cc: axboe@kernel.dk, bgurney@redhat.com, emilne@redhat.com,
 gustavoars@kernel.org, hare@suse.de, hch@lst.de, james.smart@broadcom.com,
 kbusch@kernel.org, kees@kernel.org, linux-hardening@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 njavali@marvell.com, sagi@grimberg.me
References: <yq1zfajqpec.fsf@ca-mkp.ca.oracle.com>
 <20250925130729.776904-1-jmeneghi@redhat.com>
 <fcdb0a83-3b1c-42bd-b58b-b501cfbf27fa@embeddedor.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <fcdb0a83-3b1c-42bd-b58b-b501cfbf27fa@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_071822_178338_5C0C77DF 
X-CRM114-Status: GOOD (  15.82  )
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

On 9/25/25 9:38 AM, Gustavo A. R. Silva wrote: 
> On 9/25/25 15:07, John Meneghini wrote:
>> This reverts commit 6f4b10226b6b1e7d1ff3cdb006cf0f6da6eed71e.
>>
>> We've been testing this patch and it turns out there is a significant
>> bug here. This leaks memory and causes a driver hang.
>>
>> Link:
>> https://lore.kernel.org/linux-scsi/yq1zfajqpec.fsf@ca-mkp.ca.oracle.com/
> 
> Thanks for the report. I wonder if you have any logs or something I could
> look at to figure out what's going on.


We have a fix already.  Chris and Bryan figured it out.

> Bryan,
> 
> Could you please share how this patch[1] was tested?

Bryan, please reply with bug fix patch you emailed me yesterday as an RFC patch.

Gustavo, this patch is being tested as a part of our FPIN LI changes. To run this code you need a Brocade switch and a whole lot of hardware.

You can see a example test plan here: https://bugzilla.kernel.org/attachment.cgi?id=308368&action=view

I am about to submit a version 10 patch series for these changes and I will include a new/fixed version of your patch in that series.

/John

> Thanks
> -Gustavo
> 
> [1] https://lore.kernel.org/linux-scsi/20250813200744.17975-10-bgurney@redhat.com/
> 



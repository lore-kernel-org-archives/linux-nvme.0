Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEEDCCA470
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 10:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LdJuTKOf/1oQDjnzdAFIGDSMiQQ/LUgyrgeX0PFVxss=; b=XKjmdAoK2yx3pCBR3qkQ5z/jAJ
	s74foZ2gqdLqtOztvTkhfchfuaaiAfQhx254wOV1QSXymZPDZHTq9s1WgEPvLuJ98Rfa+VP4h9Z6G
	hU4Sn2qvYHlNrhOjT4+yed6ttoDFZAFzXjLjXrLtzxOGPlEaXEHhYo4QiS4YmZT9g/MT6VvhpgNWl
	s+QUyZWyiVXWjBlHXDkmfQmk0R8cYdLrFTNTXMCtsznC93Ed/eO8bZgchZsWYxwfwIZoykvR7vH/R
	/veIIEJBnTiNEI4pIDULEzr2w91JbC3ltn/1ndziPgml3cS3/z7bXvyKC+ihzyvdjvoKUyrsLsWsN
	8EIiAXJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3XQU-00000004z86-2EW3;
	Tue, 30 Sep 2025 10:17:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3XQS-00000004z6l-0M7C
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 10:17:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759227459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LdJuTKOf/1oQDjnzdAFIGDSMiQQ/LUgyrgeX0PFVxss=;
	b=EN3IiMfw2zu8IYtzdi/vqLFf+Fu/KyRpLXVxYDMdA2sNeVOGFHHMmkg33/+e2EADXIkRC8
	OLU+C2Z1Z83jvOngXGk9/jg8O7jzv0NCNiM7CQ3PbvwdL4mR6qjtXNvkDpddSkSitGyJX/
	nVu7K8SJDsQL+WwBkapGM7jmlYTd2BY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-J7GdcnEpOwauqhdqpvL-Gg-1; Tue,
 30 Sep 2025 06:17:35 -0400
X-MC-Unique: J7GdcnEpOwauqhdqpvL-Gg-1
X-Mimecast-MFC-AGG-ID: J7GdcnEpOwauqhdqpvL-Gg_1759227454
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A90951800378;
	Tue, 30 Sep 2025 10:17:33 +0000 (UTC)
Received: from [10.44.33.194] (unknown [10.44.33.194])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D16A2180035E;
	Tue, 30 Sep 2025 10:17:27 +0000 (UTC)
Message-ID: <eed2bd71-4938-47c9-a0b3-6d24f06a7361@redhat.com>
Date: Tue, 30 Sep 2025 06:17:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/11] scsi: scsi_transport_fc: add
 fc_host_fpin_set_nvme_rport_marginal()
To: Justin Tee <justintee8345@gmail.com>
Cc: hare@suse.de, kbusch@kernel.org, martin.petersen@oracle.com,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 bgurney@redhat.com, axboe@kernel.dk, emilne@redhat.com,
 gustavoars@kernel.org, hch@lst.de, Justin Tee <justin.tee@broadcom.com>,
 james.smart@broadcom.com, kees@kernel.org, linux-hardening@vger.kernel.org,
 njavali@marvell.com, sagi@grimberg.me
References: <20250926000200.837025-1-jmeneghi@redhat.com>
 <20250926000200.837025-8-jmeneghi@redhat.com>
 <CABPRKS9SkaGZjC_vEy-YdgYELffGLvub7DTFGCYXFW68ObWqYg@mail.gmail.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <CABPRKS9SkaGZjC_vEy-YdgYELffGLvub7DTFGCYXFW68ObWqYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_031740_235972_7A8C1F65 
X-CRM114-Status: UNSURE (   7.90  )
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


On 9/29/25 1:45 PM, Justin Tee wrote:
> Hi John,
> 
>> +       u64 local_wwpn = fc_host_port_name(shost);
> If CONFIG_NVME_FC is not enabled, then the u64 local_wwpn variables
> aren’t used anywhere.

Oops.  Thanks I will fix this in my V11 patch series.

/John
  



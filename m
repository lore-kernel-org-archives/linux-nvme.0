Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DD1C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  2 May 2022 20:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fI5Cfu4kNyVGJ/wQZiI4GTFrDOLeeBByouu3lUou0x0=; b=psOtU0r0tK30csfYDEcMhq5jqR
	yY0YnnsFop3+s2JUUdU8aWIE4hJBRZYChh2PQBwrr7D6uzRSOQbyx9XKMccRrynihsSazV6QjEbLJ
	rqnhbp/FVIKwfOcvajhrQByhv0X6cugl/2tI6EIlHSBTTYJSAzsRUrC9+/02ErLYYfN87FdsIxOQp
	Ifk8RvHCoqLQ+W+tRkZ3lR9Ks+uwipKKQLq/SLS7hosm6ZRUyDEFMeKFDLSVUPev/sjYIOMM0rHx9
	kNOwp3w2b6DZujN98u0fuztNdjjtrl+qcxGcGXA8xTz3nhJG9etDBLl14JY8yKfZl8LiPGpUSMq6G
	u/ZM0xxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nld1M-002hnY-2U; Mon, 02 May 2022 20:51:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nld1A-002hji-AC
 for linux-nvme@lists.infradead.org; Mon, 02 May 2022 20:51:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651524698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fI5Cfu4kNyVGJ/wQZiI4GTFrDOLeeBByouu3lUou0x0=;
 b=ZNFhiYChzlBy5/R3VmqsyAwrfVVlAF05aND0WzyB+CtDRjlr8xJYCYCnluzbGjNv/2V1zp
 CT7whZTnpa50UsHtYtaXx+2VqE6wc7govl0FNT3NFiNuGiv31Trs1XEUlbiwE1ldR3vjOC
 2R4Fetl0IMhoSStodVsM1aNG4X002wY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-JXOFyoIyPUmonuHNc5Q5vg-1; Mon, 02 May 2022 16:51:35 -0400
X-MC-Unique: JXOFyoIyPUmonuHNc5Q5vg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2509B1014A6B;
 Mon,  2 May 2022 20:51:35 +0000 (UTC)
Received: from [10.22.34.177] (unknown [10.22.34.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA7F040869CB;
 Mon,  2 May 2022 20:51:34 +0000 (UTC)
Message-ID: <fbf87f68-88b8-4bfc-428a-7447b043b2b1@redhat.com>
Date: Mon, 2 May 2022 16:51:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: LSF/MM: IO Track Topics
To: Omar Sandoval <osandov@osandov.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ewan Milne <emilne@redhat.com>, Chris Leech <cleech@redhat.com>,
 James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 Daniel Wagner <dwagner@suse.de>,
 "Knight, Frederick" <frederick.knight@netapp.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Kanchan Joshi <joshi.k@samsung.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <d43a7624-0e9a-4cd9-05b5-caf3b8ea3065@redhat.com>
 <0d76d989-7f38-9235-14ee-c9cdca693692@redhat.com>
 <YnBDul1cxKvHudRj@relinquished.localdomain>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <YnBDul1cxKvHudRj@relinquished.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220502_135140_469163_46880921 
X-CRM114-Status: UNSURE (   9.92  )
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

On 5/2/22 16:48, Omar Sandoval wrote:
> John, does the 1PM slot tomorrow work for you for this topic?

That works for me. I'll try to prepare a couple of slides so we have some talking points to guide our conversation.

Thanks,

/John



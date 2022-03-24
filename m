Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743A4C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 00:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fA6JtXHpko5hNknJ/C+1Zhwc3NAmcwMnmyzylLClCik=; b=k2XLCQRtMtWChFZGu2XqOSXkbZ
	/sRRj+YYIrLWD+aEaz/Y3dDZjs+Gxz3lOYix1142pKFFR3bNTr9BwUgulszinyFxWM5R6BskaBV1A
	2W9QnKuR93TYN6rZvazXEjMpRyXlkQnbl5ceDQuNNQI+Q49k+PqABB175aMll0RaX4DB9mLdw1Mvu
	dE0ZUR0DdEyugzoV+gI49kAvmVm0k3fFq45BUFlM+HY5moF7A/qdFq85xxtlTHLadV6kdvo0stb3k
	IVDConOYMl16ly1kgH69dFzJCfCzN9ye+qR0G6hR+rmtqjg/c6wC27xvr+XTf/J6NES3XDh+CjB7+
	YDQSWLHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXBi9-00FEuw-Hh; Thu, 24 Mar 2022 00:52:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXBi5-00FEu9-Sl
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 00:52:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648083133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fA6JtXHpko5hNknJ/C+1Zhwc3NAmcwMnmyzylLClCik=;
 b=gRzbWKKFaa9wiWDnGL78dJG0HIfXDXCDJebum6k00+o29lrJQtgo/p9Sw8mIUc68sWkRO0
 lDrgGK0dIvMo+R//2r8Fkfx2aU4imZNsPXR+eQli6THbtVNqbqnDUTLAZFKSBPhw3pm14p
 BLdJZ5nLJrdNiDxXZUobe9n1GH03RCk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-GHIUhL2bOdqyiq_QNFH6wQ-1; Wed, 23 Mar 2022 20:52:10 -0400
X-MC-Unique: GHIUhL2bOdqyiq_QNFH6wQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF698185A79C;
 Thu, 24 Mar 2022 00:52:09 +0000 (UTC)
Received: from [10.22.19.101] (unknown [10.22.19.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A077C40CFD05;
 Thu, 24 Mar 2022 00:52:09 +0000 (UTC)
Message-ID: <c0735336-4c4e-c355-51db-14ac56a2e8e3@redhat.com>
Date: Wed, 23 Mar 2022 20:52:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/3] nvmet: restrict setting of discovery_nqn to discovery
 subsystem
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-3-hare@suse.de> <20220315080908.GB3082@lst.de>
 <42045e78-dce4-2653-e882-46c48cc6e64e@grimberg.me>
 <20220315090030.GA4321@lst.de>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20220315090030.GA4321@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_175218_160498_E96F132E 
X-CRM114-Status: GOOD (  13.46  )
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

On 3/15/22 05:00, Christoph Hellwig wrote:
> On Tue, Mar 15, 2022 at 10:57:35AM +0200, Sagi Grimberg wrote:
>>> It is a fairly recent addition by you and without nvmetcli support, so
>>> maybe we can revert this entire attribute to redo discovery controller
>>> handling, but as-is this patch seems rather broken.
>>
>> I think we could, I doubt anyone uses this interface at this point...
> 
> Then please send a revert for "nvmet: make discovery NQN configurable"
> against the 5.17 tree ASAP.  That way it will only be in 5.16.

Has this patch been reverted yet?

I don't see the revert.

jmeneghi:centos-stream-9(nvme-5.18) > git logl -200 --grep="nvmet: make discovery NQN configurable"
626851e9225d 2021-10-20 1632292519  nvmet: make discovery NQN configurable [ Christoph Hellwig / hare@suse.de ]
jmeneghi:centos-stream-9(nvme-5.18) > git branch --contains 626851e9225d
   5.17/scsi-queue
   5.17/scsi-staging
   master
   nvme-5.17
* nvme-5.18







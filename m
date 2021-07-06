Return-Path: <SRS0=sCQG=L6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADCDC07E96
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 18:37:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC7761A11
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 18:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC7761A11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OuAThszgGnaLJP1/qg7WHRRGGiXWqq08uyuxK+EQfUA=; b=3oi3NegD4O7beL
	Mh1DnJQv5JqpB2Lpf8aBmETTerzugd0eVEhChsuJFjv2keiQE2OOd14e4HnB8InAtB7En+TpaPSO7
	eds6qDEdjnN9bDgYqK/FhbQ7QVr8tmxmTlApPzaIyxbMdK18OKL9L6FtKM/9uqt11kkp5X5rQqPeP
	bVTuuDbBopBPyiRUQlG9g3gQaUH021h1jBlAutoinustSVKJXJAalLvtCv0/tSMeJ6gC7HVPmR2DH
	jVcjq/hnn3aAV133r3Gy9ytRkX17Un3OimRpKxZVB1KGLLNnkHcGWJkFjVaLoEDXBHLiliupyH/FQ
	HYB2+jIoetuvMR2EJZAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0pwp-00CaQw-2h; Tue, 06 Jul 2021 18:37:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0pwm-00CaQe-S1
 for linux-nvme@lists.infradead.org; Tue, 06 Jul 2021 18:37:30 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B43061A11;
 Tue,  6 Jul 2021 18:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625596648;
 bh=Z+iRC8d31BOaDeyFln5LpsnDHiUtIJIZ/jUI5UuNLJ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OeF7k7UVes6QV2Khcz/f0vRnM6/q9OOQrxZnATsFOnCOM0ygu/sLLqSE8ml67Hhh3
 w3KtQI7ZM0XWh0jnBx7g9w8VkoomLPmDx9Y3wMFfSkDxfJi+5sJQsENA9NiQyS7ATu
 MsFuWc4/4aO3S6zh3/OYOjSU9BonUn5cGE4w6XRRyjEkepM+18Qyar3yodvBEpactC
 jhYIbypCRRh5Fi1IJ25vEV69czufRdmzHqrApVqy7pQhKBTIhH3NNwV26gNTPCMiwh
 bb9U4ZEb99ShVT72xIm+W2R+d7MIfTiwaZX0sP0t2ITszOuzaj7qpwfjlKUciVUP7g
 ODNsRduwiDyrA==
Date: Tue, 6 Jul 2021 11:37:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Casey Chen <cachen@purestorage.com>
Cc: linux-nvme@lists.infradead.org, yzhong@purestorage.com,
 ashishk@purestorage.com
Subject: Re: [PATCH 1/2] nvme-pci: Fix multiple races in nvme_setup_io_queues()
Message-ID: <20210706183726.GA286860@dhcp-10-100-145-180.wdc.com>
References: <20210624173125.20376-1-cachen@purestorage.com>
 <20210624173125.20376-2-cachen@purestorage.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210624173125.20376-2-cachen@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210706_113728_968052_32131C4D 
X-CRM114-Status: UNSURE (   8.94  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 24, 2021 at 10:31:24AM -0700, Casey Chen wrote:
>  static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
>  {
>  	struct nvme_dev *dev = nvmeq->dev;
> @@ -1590,8 +1613,10 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
>  		goto release_cq;
>  
>  	nvmeq->cq_vector = vector;
> -	nvme_init_queue(nvmeq, qid);
>  
> +	if ((result = nvme_setup_io_queues_trylock(dev)))

Please separate the assignment to 'result' from the 'if' checking the
result. That way will be easier to read an matches the rest of this
driver's style.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

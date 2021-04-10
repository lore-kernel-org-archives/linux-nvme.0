Return-Path: <SRS0=Ubpo=JH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FB0C433B4
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 06:46:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BED610E5
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 06:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BED610E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/pyOw1zAdS+fWzL0v3XEFCzWEPt+xaBoP+tKuIrn5NY=; b=XfYEK3KQqlXbK5pOaj+4IG94U
	Ms9vIangJ0au512Bj2NFkq/9tKZ89i91NesAZpTOof5V+Gsbh52RzmKvYAuFYeLz1jyq6Xahjh45O
	pMpC+UrzftV3c7C8RKaSpb/AlePcC6CVeYZywhCHRgiSe5amt6nnss/69Ar9oLD4S7lpKP1QIF/Ef
	73NG1HX/gtv8cCfmpIstp/Z1hGROc6TmU/FAZpD8W0nMenEsFr87rgCBcw/5a6l9fCJiK3xTRsBBx
	GzZrLvmZZGg0qv4FcIkdIF6/JOnmK75pMUlgO3zcycUvn9+qnnQmWeq/OZqJ8ijs8I+w+MYF+MB+H
	uASMYhhSg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lV7Nf-002JI3-6Z; Sat, 10 Apr 2021 06:46:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lV7Na-002JHs-QV
 for linux-nvme@desiato.infradead.org; Sat, 10 Apr 2021 06:46:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=IYxLqntJ6IBQVBac4HSatDtD/Mu0aZ6VoImzcG8iIpU=; b=Bn+JHn5cWzOWM7oBFHsv7rRIrt
 e0gdzRwQKUT5Z6yFIukyr4/Aho8ZL8oFHvJGLs3jD4f8uL3X3JfNyPJ65FHe4KjrVvCxI4wGwSDWF
 IxvxZUE+jVKQ8Qpy4/Km5QIYmePf5dA9VF+SpPjkVCMm5aFiDbLywez1qob0ABIPE0vE018Xp3EN+
 tAPVxq1Ipw68cxvo6mqfA2iGJHq5LF1hlKIomXtrWpXyViXdikzuSLTzWVWG5nywNszHmLq6mz3bq
 37EnvROn+KPPy1o5FcpwOZ4eTjgdLLcTulr3caJ92pcmBH0lunjjpPD8gPfc0bn3BZer18GiJtbg9
 a3l2e6/A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lV7NU-001Pza-Ly; Sat, 10 Apr 2021 06:45:57 +0000
Date: Sat, 10 Apr 2021 07:45:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: amit.engel@dell.com
Cc: linux-nvme@lists.infradead.org, james.smart@broadcom.com,
 Chaitanya.Kulkarni@wdc.com, James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Message-ID: <20210410064556.GB335861@infradead.org>
References: <20210322195717.13094-1-amit.engel@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210322195717.13094-1-amit.engel@dell.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Mon, Mar 22, 2021 at 09:57:17PM +0200, amit.engel@dell.com wrote:
> From: Amit Engel <amit.engel@dell.com>
> 
> Once a host is already created,
> avoid allocate additional hostports that will be thrown away.
> add an helper function to handle host search.
> 
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>

Is this really a signoff from James or a review?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

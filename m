Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0255CCA470
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 15:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LnZ3GxoHY4tx9ymyhRib31zQjZxereqk1CN/bfHik9M=; b=iqIEz6X3zL6BhFaQgcFsdRwqqH
	ucAIiakWSHSMA+Om8jtRM0phJhxCySKx/O44+2H7qmtQ/IiA05nLTWHVWhdcL7M6T5+aT93VitNm5
	J8XvIjLzRQ3qpu1WMJOPkWi98cQAq4DI8ynWGGpmDJDmVgvqTpcxgWWaTTzE0feBjAu50UKn2F5ys
	OMINJatGKT1B71dsPiNbu+A3BvBSw9R0DV7SgGpMpXOod8dYbj28nidNW3wRPKMWkpKNFx4X0StYZ
	fi7e6uCmvfplI1hI/AgErYM8q2mXPstRKIFGyNB0QMGQR81IrJX7JebgMWBuBt+mCYwjxwsEcQ+B4
	rrBNmObQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3ypL-00000008P4X-10US;
	Wed, 01 Oct 2025 15:33:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3ypI-00000008P3m-3Xvw
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 15:33:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759332788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LnZ3GxoHY4tx9ymyhRib31zQjZxereqk1CN/bfHik9M=;
	b=RF5HB42CdrJEkvh256mPNu0UHHueK1IpO4cszvMW6iEkQ8AbnGXCIHgcxQVhYpcr/Vu8EZ
	u+cZkNOpVw1EMqhIHyXdfYV6lelOHXpJ0CtV7YEw/YmpEc/kDJWUpg6tv/yQlKhWT45AEi
	1/h3BRyytqSDt+4u888OQnp9goFQ5Pw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-2BNkSWIlPCKCUuS-7qUKsA-1; Wed,
 01 Oct 2025 11:33:04 -0400
X-MC-Unique: 2BNkSWIlPCKCUuS-7qUKsA-1
X-Mimecast-MFC-AGG-ID: 2BNkSWIlPCKCUuS-7qUKsA_1759332783
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6263018002CB;
	Wed,  1 Oct 2025 15:33:03 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.45.224.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E09A41800446;
	Wed,  1 Oct 2025 15:33:00 +0000 (UTC)
Date: Wed, 1 Oct 2025 08:32:59 -0700
From: Chris Leech <cleech@redhat.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2 0/4] nvme-keyring: kbuild fixes
Message-ID: <20251001-playhouse-disown-b9c28276ff2c@redhat.com>
References: <20251001151351.121181-1-hare@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251001151351.121181-1-hare@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fpFDp4iz9tS9Q_ZFSXj0HWTQdkF8OSg9y62SCAPbTTg_1759332783
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251001_083308_955300_EE0BA833 
X-CRM114-Status: GOOD (  15.42  )
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

On Wed, Oct 01, 2025 at 05:13:47PM +0200, Hannes Reinecke wrote:
> Hi all,
> 
> the kbuild robot uncovered some issues when having authentication
> disabled. This patchset will correct them.
> 
> As usual, comments and reviews are welcome.

Ack, fixes the build issues.

Reviewed-by: Chris Leech <cleech@redhat.com>

> 
> Hannes Reinecke (4):
>   nvme-keyring: use correct format specifier
>   nvme-keyring: typo in nvme_dhchap_psk_lookup()
>   nvme-fabrics: make call to nvme_auth_extract_key() conditional
>   nvme-keyring: fixup declaration of nvme_dhchap_psk_hash()
> 
>  drivers/nvme/common/keyring.c |  2 +-
>  drivers/nvme/host/fabrics.c   | 10 ++++++++++
>  include/linux/nvme-keyring.h  |  4 ++--
>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> -- 
> 2.43.0
> 
> 



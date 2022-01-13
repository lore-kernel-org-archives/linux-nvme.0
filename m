Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFF5C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jan 2022 16:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EsthcbcfETBfvjXpaeWKg4AA/n9QlqJtUTpp2/nVwB8=; b=vaFsuwm7Yku2u6AckCUalRah1t
	CQmr4JZRPBRQvomugbQpvnHefFfJlz69OcENBGQxl0azvPB8CRJuOy5u2K2XHnyfS00zfvnbPxnlE
	6DnZfiY3kw0rRkj3CWkOFAj5oZGJ5gUY4G7KAwG6B9l7Mr1OhDX8lf8U9uc0CSN7yKgQ5P140bjVA
	1q8WB30atEI8KYmCXqzkERCbqE2kZfRuYNi68B0aNYX1XP+dxq60gF9O8UzYAAYOGYx53ZeAm5Fxm
	Im0NjOCztSpehJxGfrIOE/GNpE14GAdn00Cj+MebtJKopTFBpd06IZt6dcMYtslo39jZ6D1ME4dRw
	Rxpj6LZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n82lO-006XPa-Bz; Thu, 13 Jan 2022 16:15:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n82lL-006XO8-0r
 for linux-nvme@lists.infradead.org; Thu, 13 Jan 2022 16:15:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 43EA961ADD;
 Thu, 13 Jan 2022 16:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E42C36AE9;
 Thu, 13 Jan 2022 16:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642090541;
 bh=gXbpw5q06S6i5INlWpEi3zJ7+XfXRIg+YIzgxEEfDKg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FMTx58ef5dQmw/+6Pbgi4ffOIg2YdYC5VIl0MHSJifi11ASPqCDPdvsma5P7QYgvn
 po7oa/d4D1mHQ2+46VpjeFAnuFE4fN2Rdd6NxRD4zPk8CYGKulYy76Su8tUl9cCNyX
 ZAQC+QQrF3ynWR7+nX3ifdVl2zz7o+cGUfcy0n9FSrS4cjAVcfCkYD76CLEO3tmOVW
 yH8mT1aOtLS9m5/o+YdD+NfAL/Ys/M6dEX/o+5syhzCX2pzPmTGGz+VgFMnMjy19Bx
 adC73DicxIQC38c+hLf8aTVBHCgEY/XMM1RoNPEJHjSIG0ppQxH+w424rpl1KwBP2J
 09IhZVRNw25Pw==
Date: Thu, 13 Jan 2022 08:15:38 -0800
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 1/5] nvme-fabrics: use consistent zeroout pattern
Message-ID: <20220113161538.GB3230285@dhcp-10-100-145-180.wdc.com>
References: <20220112062101.90102-1-chaitanyak@nvidia.com>
 <20220112062101.90102-2-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112062101.90102-2-chaitanyak@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220113_081543_135070_2DC0AD11 
X-CRM114-Status: UNSURE (   9.71  )
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

On Tue, Jan 11, 2022 at 10:20:57PM -0800, Chaitanya Kulkarni wrote:
> From: Chaitanya Kulkarni <kch@nvidia.com>
> 
> Remove zeroout memeset call & zeroout local variable cmd at the time
> of declaration in nvmf_ref_read32() similar to what we have done in
> nvmf_reg_read64(), nvmf_reg_write32(), nvmf_connect_admin_queue(), and
> nvmf_connect_io_queue().
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>


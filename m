Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906C0C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 17:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=psnf2vdFKAXENOq8/6XBZUZW2zI3JLp3NA3ERkqxEA8=; b=xAXDuSvH5JZtpbRkYRLr6yDew6
	/DENkemj11b9QVp5v4eDrmTnZ4xNCwbFJq1HfrI1A2RemUBHG2tkiN1QEIJDrinxYdc0ECyDzbfPQ
	KeZOM6qL/+aWqRRyTfGAmJjNJoBJH15VY102k1TU05AzMxuTC1N8v5h8mrlVgbcV7kNsx/N41ubhU
	O40+zroqai0sCKsdtgJZd7VCrnU1kpzvWm7bZN2AdB3EPFG0Q7F5QNbc7lJgs/wq4znprrQ4FZFqi
	1e4e1KEd6M0n9z8oSMkusIYly/HJiL4vxr24pZVWlUcp66SElSnoFsChe3L8hmHMHZMOFFpuiQi10
	Oni6ewRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSjVZ-00HY4q-R5; Fri, 11 Mar 2022 17:56:57 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nSjVX-00HY4Q-94; Fri, 11 Mar 2022 17:56:55 +0000
Date: Fri, 11 Mar 2022 09:56:55 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com,
 logang@deltatee.com, pankydev8@gmail.com, javier@javigon.com,
 a.manzanares@samsung.com, joshiiitr@gmail.com, anuj20.g@samsung.com
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
Message-ID: <YiuNZ7+KUjLtuYkr@bombadil.infradead.org>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308152105.309618-6-joshi.k@samsung.com>
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

On Tue, Mar 08, 2022 at 08:50:53PM +0530, Kanchan Joshi wrote:
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 5c9cd9695519..1df270b47af5 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -369,6 +469,33 @@ long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	return __nvme_ioctl(ns, cmd, (void __user *)arg);
>  }
>  
> +static int nvme_ns_async_ioctl(struct nvme_ns *ns, struct io_uring_cmd *ioucmd)
> +{
> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(struct nvme_uring_cmd_pdu) > sizeof(ioucmd->pdu));
> +
> +	switch (ioucmd->cmd_op) {
> +	case NVME_IOCTL_IO64_CMD:
> +		ret = nvme_user_cmd64(ns->ctrl, ns, NULL, ioucmd);
> +		break;
> +	default:
> +		ret = -ENOTTY;
> +	}
> +
> +	if (ret >= 0)
> +		ret = -EIOCBQUEUED;
> +	return ret;
> +}

And here I think we'll need something like this:

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index ddb7e5864be6..83529adf130d 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -5,6 +5,7 @@
  */
 #include <linux/ptrace.h>	/* for force_successful_syscall_return */
 #include <linux/nvme_ioctl.h>
+#include <linux/security.h>
 #include "nvme.h"
 
 /*
@@ -524,6 +525,11 @@ static int nvme_ns_async_ioctl(struct nvme_ns *ns, struct io_uring_cmd *ioucmd)
 
 	BUILD_BUG_ON(sizeof(struct nvme_uring_cmd_pdu) > sizeof(ioucmd->pdu));
 
+	ret = security_file_ioctl(ioucmd->file, ioucmd->cmd_op,
+				  (unsigned long) ioucmd->cmd);
+	if (ret)
+		return ret;
+
 	switch (ioucmd->cmd_op) {
 	case NVME_IOCTL_IO64_CMD:
 		ret = nvme_user_cmd64(ns->ctrl, ns, NULL, ioucmd);


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A1AC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Dec 2021 07:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L6jpM+wFPKBwVijim86lwT+Pd4crHPAT6RHn9+gT8Mc=; b=ax8BxZZUFlefe6WiQ/usI4Um6/
	H6eV3jABsMsJduXjb4gIYSUtewiQ3Wphwxvku5z0eEU11PYUMxJwpVPSX1RCrX9tvj5Jc9riaIbjg
	z8/K8x6RvuJu7cmEaKjIVt6ElLl71GJMym0nh5c+FCLWpYZLuFWlXATQA7vmY6BcYkQcjZ53wyNuh
	izo0xq9myfxCygU8Hi5SMj3MoHv6Gwiu727GmArP0X3/Havocx/LxPUMdOA8SE3FeD8G9zGRFT8P4
	CYx80UxkT/hIMFpCNa5PAE7FvADAhHmKdQePns0mp3GkndRndkV4H46EglUcDucanjmsLqd4DN2O7
	+6xPoNdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzwI4-009XAW-Nh; Wed, 22 Dec 2021 07:44:00 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzmUq-008WvT-IY
 for linux-nvme@lists.infradead.org; Tue, 21 Dec 2021 21:16:34 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Dec 2021 13:16:27 -0800
Received: from SJSMAIL01.us.kioxia.com ([fe80::4822:8b9:76de:8b6]) by
 SJSMAIL01.us.kioxia.com ([fe80::4822:8b9:76de:8b6%3]) with mapi id
 15.01.2176.014; Tue, 21 Dec 2021 13:16:27 -0800
From: Clay Mayers <Clay.Mayers@kioxia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "javier@javigon.com"
 <javier@javigon.com>, "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
 "joshiiitr@gmail.com" <joshiiitr@gmail.com>, "pankydev8@gmail.com"
 <pankydev8@gmail.com>
Subject: RE: [RFC 02/13] nvme: wire-up support for async-passthru on
Thread-Topic: [RFC 02/13] nvme: wire-up support for async-passthru on
Thread-Index: Adf2q4Y1jNlE3svCRZSHuwnlq+XxWA==
Date: Tue, 21 Dec 2021 21:16:27 +0000
Message-ID: <2da62822fd56414d9893b89e160ed05c@kioxia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.90.53.183]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211221_131632_623245_53B6C12E 
X-CRM114-Status: GOOD (  12.02  )
X-Mailman-Approved-At: Tue, 21 Dec 2021 23:43:59 -0800
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

Message-ID: <20211220141734.12206-3-joshi.k@samsung.com>

On 12/20/21 19:47:23 +0530, Kanchan Joshi wrote:
> Introduce handlers for fops->async_cmd(), implementing async passthru on
> char device (including the multipath one).
> The handlers supports NVME_IOCTL_IO64_CMD.
>
I commented on these two issues below in more detail at
https://github.com/joshkan/nvme-uring-pt/issues

> +static void nvme_setup_uring_cmd_data(struct request *rq,
> +		struct io_uring_cmd *ioucmd, void *meta,
> +		void __user *meta_buffer, u32 meta_len, bool write) {
> +	struct nvme_uring_cmd *cmd =3D nvme_uring_cmd(ioucmd);
> +
> +	/* to free bio on completion, as req->bio will be null at that time */
> +	cmd->bio =3D rq->bio;
> +	/* meta update is required only for read requests */
> +	if (meta && !write) {
> +		cmd->meta =3D meta;
> +		cmd->meta_buffer =3D meta_buffer;
> +		cmd->meta_len =3D meta_len;
> +	} else {
> +		cmd->meta =3D NULL;
I believe that not saving meta in cmd->meta will leak it when it's a write.=
=20
But nvme_pt_task_cb also needs to change to copy to user when
cmd->meta_buffer is set instead of cmd->meta.

> +
> +int nvme_ns_chr_async_cmd(struct io_uring_cmd *ioucmd,
> +		enum io_uring_cmd_flags flags)
> +{
> +	struct nvme_ns *ns =3D container_of(file_inode(ioucmd->file)->i_cdev,
> +			struct nvme_ns, cdev);
> +
> +	return nvme_ns_async_ioctl(ns, ioucmd); }
> +
The uring cmd flags are not being passed to nvme_ns_async_ioctl - what if
IO_URING_F_NONBLOCK Is set?  When it is, I think the nvme_alloc_request()
call in nvme_submit_user_cmd() needs to pass in BLK_MQ_REQ_NOWAIT as
the flags parameter or move to another thread.  Our proto-type does the for=
mer
requiring user mode to retry on -EWOULDBLOCK and -EBUSY.

--
Clay Mayers


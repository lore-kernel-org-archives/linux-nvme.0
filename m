Return-Path: <SRS0=7cDU=PR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AE4C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Oct 2021 17:05:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9086C60E78
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Oct 2021 17:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9086C60E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UBQu2NaBw0leNJlGUn2ClfwzgV4ttHKz2FJYUhUzXRo=; b=k6XRzZx0nF3cUdXmQQ6Rd6ah4V
	7ML5a/EfSfHsM1l91Ynlv4/lvIoGeDpTBMcEkIz14mhN1DaMLDj755r8XpBZl+GAIz36chG06plfh
	BcKZMljZavPgEXh6vVUrgVZjA/B5otucjLtsRJatyHigYMC8cgNeg3rj/YVWwiPoKpCyfK6bH0RAd
	NdHC+n8NvCJBwsHlV05QZOczr93dbZoOgwlCCVC4RHo5vwGkcdZq3UHpzQIFqsgpML+0+A6kr1M44
	kZySm3j4C0+twnoZaSsaOw93JqsUzBxd/fCr/DZV154xrImRtogB9lCDMzZWFrKcmXnVx3fWnakOS
	CH2CjTIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mgVJb-00BXfn-S4; Fri, 29 Oct 2021 17:05:15 +0000
Received: from mout.gmx.net ([212.227.15.15])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mgVJY-00BXf9-8Q
 for linux-nvme@lists.infradead.org; Fri, 29 Oct 2021 17:05:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1635527095;
 bh=UBQu2NaBw0leNJlGUn2ClfwzgV4ttHKz2FJYUhUzXRo=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=io0EmqdcFB1d01A6sQpNDNpRpAmDizeHcLp44bv9rv1WULm/MEkwc/U3bsGVCAG/M
 dJKLXUUKOfy9OFzZ5D34GFbRTHd3pM8r1kv3ts1BMWrMdBkfuwNcgh9r9GCl3FUZ4p
 T8KBXx0J502Urj4+fnDLX35Ol0dEV54078rnn7YI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MC30Z-1mUdjf3SaT-00CUoV; Fri, 29
 Oct 2021 19:04:55 +0200
Date: Fri, 29 Oct 2021 19:04:52 +0200
From: Len Baker <len.baker@gmx.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Len Baker <len.baker@gmx.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Kees Cook <keescook@chromium.org>,
 linux-hardening@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: prefer flex_array_size and struct_size over open
 coded arithmetic
Message-ID: <20211029170452.GB2124@titan>
References: <20211024172921.4110-1-len.baker@gmx.com>
 <20211027060740.GB9949@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027060740.GB9949@lst.de>
X-Provags-ID: V03:K1:KtOAKC3QeoN2eTs+KoV3lQcpfyIO3RqIyE4fzQLQGs0h+ANU3vW
 ypyFCHXnIH/AY536yHQQZ0tSJc6t8tLoCGFfTawQ7kpLr22hK1zOfATQOQCdtzCFhfvAw1p
 h9+4c43eudVUtDJCakTZyeTJ+wB5Qx4xn3j1yBW8yzZ5OPBeKU6np0Zaz1DN63L587YBdmg
 N99xdXgXUEi+75M0BOKZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H/LfKFHkclc=:hlvxRFxMJJGxCw1GVEhnU7
 Q+T3PDabx2OGw50mHEkFJzB6crrhmHf/JshrYrV0Wxoa4lN+lgs5D42ZqO3765JgzaZlPVmjs
 LwlleoB9L8gY4qY2enOgeyFfAuHFi89X2DuN/fDADIz3Buti/6AKh8uZnBLG1P5cmKm18aSR/
 7JMHepqBtSd5zssuwDy3uHV22+wKl0v4eeafcUHBwn+cxpYuqCa2MbPsONEpyY1lXMq9SyVb/
 KV1J4+4ZE7olcFEXzvA9KpQKUhCLyG5g9nz3JnWvUz/Nomgul6GQVCIztifBO3tS8j9JPVeQx
 iSRou2+SDD/1rrvN7Shtn6n9ZA5nGglVyjrHez+YNgqP/Xh5ua+nXTFA05U8RZzKekjwnaqwW
 cD4Ro16EqnNRepyDZ8UP599vhEYO0o9TX9Gn81VTJgQzNnC6S+ktIezCiZmlquurZ9cOLlvtD
 N78hjkdVJCrYkD7ywzG3tZezFFFXqU6yv+VEgeDAvEtOKgEB8qRnnmWdmAfK+g7NfFYAKLXM0
 E/tcSthRTewkagbGgy1y5WF9uRwyHzyC6KpwBVX6VNP4ZLqnlBihoBPEifAwOPh89zwmbT3r/
 760pvcjorlIc6I98w61C/yoh9N+S+J6ibEGSCl5hPwwDsZCDJrF23JH5j4qfR1FPlgeKHGXJc
 VosReCJ0eRC7FASgAQv5v87cXgFLGFy9+lfE+NBYxCXeNLYES5ubJ00pNrxzA6+j0FpFemZI7
 fVRoTp6/0FMZGIa0KpBU3mPqa5FpI9EwUbehHvJ2sRLBK9hYOH5DODIbUAGdYmYSrq3m0zz44
 dZm3jzCVaGIM9X0Z4UI/vsMEd/ISdB8RwcT/wXHvVRVoIZO5b25ZJLZWr66S7Rwezv0RDRIaU
 uJbtlyDi6iOZFDdLml54NsyjBBOcgECYrstBsKwDOs+uXtqW8eu29tGfUkI8iR7yLc+0pzRXG
 RRrBNwk1l1cUwIcnZs374/n3vOBDw81IGwVkoEKetPcY87NrcdpO7rPKgUjPZYtTMcamlUDes
 H03EvGiFo/TFyuexWNdMFTDaGSrC1jg196KE3p6GWNBAA9UVIgcBXqIpesabUXgxPvVUdwHHi
 6dDUhbwO50XNCw=
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211029_100512_621051_286FA610 
X-CRM114-Status: UNSURE (   8.55  )
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

On Wed, Oct 27, 2021 at 08:07:40AM +0200, Christoph Hellwig wrote:
> Thanks,
>
> applied to nvme-5.16 with a fixed up subject.

Hi all,

Thanks Sagi, Chaitanya, Gustavo and Christoph.

Regards,
Len


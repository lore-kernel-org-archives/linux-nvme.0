Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD594E88D70
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 05:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yb605lKVp/GZqZOgKkIYclNBctJ6DyMj4RFRGDR1K84=; b=cqE0dY/iav8UqmuTXIZKxHv1Ka
	NOnPtJ00GHyTRgIz/pMQbW0kyVbCBmJE5u/UjrwaFqSrIu+5m/m9yNX4724GLFHodX23dUKS/mNPq
	jDjh8OxX/X6ypX598jTTK1D7vuwiEoOncWiRJuSQuW0pFOZEdlC5HXc3Tlc4OFCxBtX1jr0KGNJcr
	pollQecyd4vafL7+i8rq4cHyG5c/NyY5/ONM/vUgbMWkrkoc4n4T9zChO/gkmEf8GGmebOCIvf9qw
	berZIWBoHYqN0vSO3hXWJyZ/uvH43Bam+FWa+m6+x8ZNVMb5x5NcrMj7P/Cr2Edn8pR/t96ZEZrPB
	yYHwI2zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8tNC-000000039Pn-1jLk;
	Sat, 04 Apr 2026 05:16:42 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8tN9-000000039PQ-3rc7
	for linux-nvme@lists.infradead.org;
	Sat, 04 Apr 2026 05:16:41 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-509069a7a7fso885421cf.0
        for <linux-nvme@lists.infradead.org>; Fri, 03 Apr 2026 22:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775279798; cv=none;
        d=google.com; s=arc-20240605;
        b=clyy5R3rgUourxZglcYRY/B1JbykxN/SA9ApWoRtNIFm6+B2EDQ8bHeq9IF83NXJLj
         bwQPCvW70l11JegnNXXKZNTsflh5YjfcKzMj27BHGtdAoEnzPOFBXl79NI8yobsq85D9
         zi9RR0coAGQs9MAyG4/9a69+1j2aM+PfCAmBZVswDwyuJzcLfH60uAzue6cosTnRY+3m
         z4JVrKcODuN7Z1Swbrr16t91GpgfoUZoqCTnEI2eruiEtUlAiAZ0RmVK4L+eZ+rKCngQ
         lL50GFLt60rBhWc6MB4nBaVtAnXOT9DRHACtAXEbiD1D0zw1iia5L9pMpKl+5NxPrHpb
         NRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yb605lKVp/GZqZOgKkIYclNBctJ6DyMj4RFRGDR1K84=;
        fh=QNvH0HXeHb1AbjBsmcIwXi128VEC7BXGap0tg+ewtR4=;
        b=j5t2JSNHmhZ5i2Ye11x3PFiuvQMxncsGZ0PywG1FU324iTATIwIssaj3kUHWXOnR19
         WcLxwq8MPc/deWbch3oYEyL0xwqfq/n2gZHiYn38COtedw871DP+M4q8E3HWiqRHqvrt
         lLNLNS+R+UyS5E4I4OXbIdOc7zUN/Xk9GyGHYEXfgOuTUs6qLLcW+NgBUa3ehR9kDtz8
         cPNb5mzhSkcAty9mfvqkukpnY7I5go2pRoXji81+IPxz2U94hmIg6/Dp41sEWCUIGaT4
         e3nFBJi4g6U+k9W0XbmSOc+bzwJjkwRhx+ozxGFRIREIv357MeSGurtzckyO1KB/GGEp
         Rv1w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775279798; x=1775884598; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yb605lKVp/GZqZOgKkIYclNBctJ6DyMj4RFRGDR1K84=;
        b=NfEwP4uLHfDShfyUTI4IqZOKHFCf89ymzd/F9UZ0f7kIvm3wFTMhrj/HQMnDzxoltM
         fKB+oWb/FCVi/WBnZN4FEUdTxQj1zEvZlTN3Cpf+418ru8VZv1WXzGM722FQD/sUyjTE
         UiR+RM3oE4usXPjYXHs0w6JSU9jd6hw9OJFU8AxENbE0jPWJX1ZkV99xgH1SHZr7iRaR
         x4ogah+CfhyTULHsKERoFVyF95uqtXhaacxbddknWMGGT3xFoCnrGwuWGetS5f46kJEU
         nkwZ/JvNAHkZaCFS4QYGvg4BlPTpiYOEpzLVZEvKKrXofskJYs3XF7mfAfeSvKrH+XX6
         qDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775279798; x=1775884598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yb605lKVp/GZqZOgKkIYclNBctJ6DyMj4RFRGDR1K84=;
        b=oCihs1DhgN5SxdIO4AUoIkO+AfTry0V9SBMox6K7DNEhIqjdC80v1RX1ZmlDKAm9Q/
         QECi7ECB0dHpOeWoOVBy3dWHenCXNXSt3JflUz/IxH3N5havklMLGuv+4SRIMIi8rtrP
         zkVy04dd+rOTxGk3BS7ZY3XG10aa6bMCSbKZuctox+8ahrNgqcI2jqDf1WeRJk/q5G6O
         1fDqDe4wHvaNjWZ5jdyTr7PwmjEOAD4rIH67LViPa81RUeLuc0t0zH3PmA+qRTvFd5Y+
         LSeKJO085IP8e7PXnoCfGgg550HgclfXvPOCSGmKZPeBTx4US03VJ/cep7RtvGoG+GqY
         pB5w==
X-Gm-Message-State: AOJu0YzqieDghY4178utzejFvgRYqdBfpquKT2yKwoKgHPqj9Erv2lq9
	fFR1c6HJ1h3N3mR48u2rZfOQmYyxj3QbYGFPXrSyvQRnWpP4rtnOKEZeitrhiHKF5QEs/XcWj66
	EJzKFzueEhmWxCIy5dKW8SgmSo9oHBjUw5e0XbV5f
X-Gm-Gg: AeBDieut0Dq6Pw9ZHsa4ZmBNxOt5sOzFhIh/gIHKXPgsJpSL90bFNiL9tRfhEMzs2G+
	x5D1ai8rInqd/D4aUx2ySaEcoekXS63mvJpLMePl/jvlDb8EFy/70YLmSX9P/7uij9/STBEZ1mW
	x0n8xGjVjodqlCaDdragu8KJ1JcB0ekn607RrlK6ZbaRKunHPDf4J4n16oxCrsmsDFyYygAdDCw
	97xTIh0adGpxMMEsXpiJaZZu9bOFuBObvOjYEXv7YnLYbyZ1ePElL7U0dlqAJiG+yqY03m/VOp3
	eUAVvlZHJLd1VjfJfswCWQgeXyLszWwmLdwykrIAtvXMEpwNI2A=
X-Received: by 2002:a05:622a:684f:20b0:509:2cd4:b705 with SMTP id
 d75a77b69052e-50d63eb03bemr17889111cf.4.1775279797390; Fri, 03 Apr 2026
 22:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260402073001.2039625-1-shivajikant@google.com>
In-Reply-To: <20260402073001.2039625-1-shivajikant@google.com>
From: Shivaji Kant <shivajikant@google.com>
Date: Sat, 4 Apr 2026 10:46:26 +0530
X-Gm-Features: AQROBzDtPFB3LrL89ArMSPFgvkXkqsGeNgFG00L9nKVDphRhkke4IXXiw-IqTvI
Message-ID: <CAMEhMp=zrZ6TmNEP4xu6suES=XtyuRcMQYprntzoJZnorfN9zA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] nvme: enable PCI P2PDMA support for RDMA transport
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pranjal Shrivastava <praan@google.com>, kch@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_221640_022152_D4FF53BF 
X-CRM114-Status: GOOD (  19.27  )
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

On Thu, Apr 2, 2026 at 1:00=E2=80=AFPM Shivaji Kant <shivajikant@google.com=
> wrote:
>
> Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
> RDMA controller supports it.
>
> This patch depends on the PCI P2PDMA support added in this
> patch [1].
>
> Suggested-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Shivaji Kant <shivajikant@google.com>
> ---
> [1] https://lore.kernel.org/all/20260323234416.46944-3-kch@nvidia.com/
> ---
>  drivers/nvme/host/rdma.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 35c0822edb2d..09eefd7c3ff4 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2189,6 +2189,13 @@ static void nvme_rdma_reset_ctrl_work(struct work_=
struct *work)
>         nvme_rdma_reconnect_or_remove(ctrl, ret);
>  }
>
> +static bool nvme_rdma_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
> +{
> +       struct nvme_rdma_ctrl *r_ctrl =3D to_rdma_ctrl(ctrl);
> +
> +       return ib_dma_pci_p2p_dma_supported(r_ctrl->device->dev);
> +}
> +
>  static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops =3D {
>         .name                   =3D "rdma",
>         .module                 =3D THIS_MODULE,
> @@ -2203,6 +2210,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_op=
s =3D {
>         .get_address            =3D nvmf_get_address,
>         .stop_ctrl              =3D nvme_rdma_stop_ctrl,
>         .get_virt_boundary      =3D nvme_get_virt_boundary,
> +       .supports_pci_p2pdma    =3D nvme_rdma_supports_pci_p2pdma,
>  };
>
>  /*
> --
> 2.53.0.1185.g05d4b7b318-goog
>
JFYI the link to v1 patch:
https://lore.kernel.org/all/20260401103441.1229964-1-shivajikant@google.com=
/

Thanks
Shivaji


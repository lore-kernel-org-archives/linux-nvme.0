Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12095C07545
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hr51PfaDSaLfIEvTyl0hp741JB+LFD0qB8xlKeVwiNc=; b=4WePI1hC/aR/Ncmre6e+GSW+2X
	rqVnw++SsfQPURZfeYWbX3A+sZEQB7fIaEztlnzolswv7QVAjFhjOjvTaYcMozH5U1LoECZFXe2fN
	O06XPzhqFzR2niEBgr3G7w45dTeh6z7NZoHt9EJBedhRfYfkSE6FO39exHnPGRbQ8dpCZrtCfBZNk
	4srC2Chl9P/XzytWPIbQmmVP2Mq7CZI/oe8FTiB1/1NqxYzw2kPlnFnzdMVUB3xD33R59Fpbb+OoN
	aMgfI6PAYHEapqviERJi8Hnl5HsPk5aSd4g6fNtzFRP+UfNaE606PGV8USJUFqaMAbDRCaE/6Il9c
	5qF3Dcrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvduu-00COuQ-2U;
	Wed, 25 Oct 2023 13:27:24 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvduq-00COtH-1r
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 13:27:23 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231025132703epoutp01ae89499eddc1f62d762fe3eaa959fe65~RXKrTkd7J0521105211epoutp01h
	for <linux-nvme@lists.infradead.org>; Wed, 25 Oct 2023 13:27:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231025132703epoutp01ae89499eddc1f62d762fe3eaa959fe65~RXKrTkd7J0521105211epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698240423;
	bh=hr51PfaDSaLfIEvTyl0hp741JB+LFD0qB8xlKeVwiNc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=C9jE+Vhwu3mgFHjFTzoVocImhRDhLUCo46PLwdh+cu1/HGhvBsw2ZO91W8pbQtKp4
	 StPSjIfEETbXh2fFKswcK0wEcsBXzMq5q6DCFaAOSzK/xxdRh77XNOLURXsmqAITJ/
	 x1ZlN9x+dQwxkc58B2nERwkNhKuho+i8x+rbpLmk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231025132703epcas5p2f54ba9a1db195570322ec8bd52e61e0b~RXKrG8fO21959319593epcas5p2f;
	Wed, 25 Oct 2023 13:27:03 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SFqTd6p6Pz4x9Pp; Wed, 25 Oct
	2023 13:27:01 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CD.25.09634.5A719356; Wed, 25 Oct 2023 22:27:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231025132700epcas5p4f8535021e9d20d9138f6b7760496dfde~RXKo3bvtd1826618266epcas5p42;
	Wed, 25 Oct 2023 13:27:00 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231025132700epsmtrp2d805cbf00bddc2a99cdffd39630bed3d~RXKo2AwNB1596615966epsmtrp2k;
	Wed, 25 Oct 2023 13:27:00 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-e8-653917a53fde
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	43.66.18939.4A719356; Wed, 25 Oct 2023 22:27:00 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231025132659epsmtip16083c40b111275ed6b55c9a9f587d7d6~RXKnqNzMK1831718317epsmtip1T;
	Wed, 25 Oct 2023 13:26:59 +0000 (GMT)
Message-ID: <5c4d1a88-ca9c-cccf-fec6-ee854cb775ae@samsung.com>
Date: Wed, 25 Oct 2023 18:56:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 2/4] nvme: use bio_integrity_map_user
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, Keith Busch
	<kbusch@kernel.org>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231018151843.3542335-3-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmhu5ScctUg0tHTSxW3+1ns1i5+iiT
	xbvWcywWkw5dY7Q4c3Uhi8XeW9oW85c9ZbdYfvwfkwOHx+WzpR6bVnWyeWxeUu+x+2YDm8e5
	ixUeH5/eYvH4vEkugD0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfV
	VsnFJ0DXLTMH6CIlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66
	Xl5qiZWhgYGRKVBhQnbGjEOL2AqesFWcuNDF3sB4kLWLkZNDQsBEoufgOiCbi0NIYDejxMF3
	O5hAEkICnxglZi1wgUgA2Uf617LDdBz+dIUJIrGTUeLakmdQzltGiTkfDzKDVPEK2Ek0bW1h
	AbFZBFQl9i67zAoRF5Q4OfMJWFxUIEni19U5jF2MHBzCApYSU6/HgISZBcQlbj2ZD3aFiECV
	RN+0n2wQ8TiJpUdmMIOUswloSlyYXAoS5hQwl5hzfgoLRIm8xPa3c5hBzpEQmMghcffnJqg3
	XST+PIV5WVji1fEtUM9ISXx+t5cNwk6WuDTzHBOEXSLxeM9BKNteovVUP9heZqC963fpQ+zi
	k+j9/YQJJCwhwCvR0SYEUa0ocW/SU6hN4hIPZyyBsj0kXl9/Ag3o7YwS+w/MYZ7AqDALKVBm
	Ifl+FpJ3ZiFsXsDIsopRMrWgODc9tdi0wDAvtRwe3cn5uZsYwclVy3MH490HH/QOMTJxMB5i
	lOBgVhLhjfSxSBXiTUmsrEotyo8vKs1JLT7EaAqMnYnMUqLJ+cD0nlcSb2hiaWBiZmZmYmls
	Zqgkzvu6dW6KkEB6YklqdmpqQWoRTB8TB6dUA5Meg55Wj9JD7vMTDmt4XZLKf7OWdW2L6urt
	uzUuH7L8tctDovFWkGULT9JDmzX/p+a1xhxq2OnxQSP1ekvZgycGS7NuTSzal7jj/v8P0Ymd
	t+f4G17dUaezL3VtywM/xovt6ZE/Mh8VFT6Yu//Su3Uz+j5O/N9dypngeEdZ80lNo6qiaUva
	jDKLp7xK3SvOm9VPZeH/l/nm0sLLcrmX30pkLNRbwOpa9jebb/oz7oVbj9w/92zJA5t3mzau
	PWj1bnXohZP7dpyUkOVTarwiFKLg+tS6Vk7siY46x475108xvnrnoWR3g//ewoxdW629bvlt
	ORd1ZetElpQ9OzJ7r2m8Y19qvLrYLMYia/LMaPEPSizFGYmGWsxFxYkAU4S/XzcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnO4ScctUg765Char7/azWaxcfZTJ
	4l3rORaLSYeuMVqcubqQxWLvLW2L+cueslssP/6PyYHD4/LZUo9NqzrZPDYvqffYfbOBzePc
	xQqPj09vsXh83iQXwB7FZZOSmpNZllqkb5fAlTHj0CK2gidsFScudLE3MB5k7WLk5JAQMJE4
	/OkKUxcjF4eQwHZGiWN3PrNBJMQlmq/9YIewhSVW/nsOZgsJvGaUOP2pFsTmFbCTaNrawgJi
	swioSuxddpkVIi4ocXLmE7C4qECSxJ77jUALODiEBSwlpl6PAQkzA42/9WQ+E4gtIlAlsf/H
	WSaIeJzE/0uNCPdMnXqFBaSXTUBT4sLkUpAaTgFziTnnp7BA1JtJdG3tYoSw5SW2v53DPIFR
	aBaSK2YhWTcLScssJC0LGFlWMYqmFhTnpucmFxjqFSfmFpfmpesl5+duYgRHkFbQDsZl6//q
	HWJk4mA8xCjBwawkwhvpY5EqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc5pzNFSCA9sSQ1OzW1
	ILUIJsvEwSnVwLTi8PdJFx4/8bZgNnus3LTpkaVrx4PZiyZsV7kqsejsxMdMSu+SPge7TjzB
	c8dt+hKJWzN0n341ulu6b43tqpWywU78Tz6JPMzy+infWq35nHvxkwaZJaFPA1IvTG25rj6x
	ZdqOsgvlDdf0V6nKbD0RVVXe5r587Tkxpe1NT6fHevuci+urUZqQKvQ9eZPffakEjmWtUaxr
	yq0ehiiG71GbJHVu2Ueeo/4nFgQxObDFv/h8pVHd7264rhH/xAdRRfwrOVTzXa60Ol8IFVj1
	yW/1S/3dlzbk+wvmZEtJ98/ua57TeefKH9uF9gv4Fj9Lv2wbUyU0WcniRMfOjCRjpfoHKdUC
	u0TnhurPUCk5xajEUpyRaKjFXFScCACoklrHDwMAAA==
X-CMS-MailID: 20231025132700epcas5p4f8535021e9d20d9138f6b7760496dfde
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018153235epcas5p3c89cd65ddf817849f7450e8043538375
References: <20231018151843.3542335-1-kbusch@meta.com>
	<CGME20231018153235epcas5p3c89cd65ddf817849f7450e8043538375@epcas5p3.samsung.com>
	<20231018151843.3542335-3-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_062720_978422_F7E43780 
X-CRM114-Status: GOOD (  14.71  )
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

On 10/18/2023 8:48 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Map user metadata buffers directly instead of maintaining a complicated
> copy buffer.
> 
> Now that the bio tracks the metadata through its bip, nvme doesn't need
> special metadata handling, callbacks, or additional fields in the pdu.
> This greatly simplifies passthrough handling and avoids a "might_fault"
> copy_to_user in the completion path. This also creates pdu space to
> track the original request separately from its bio, further simplifying
> polling without relying on special iouring fields.
> 
> The downside is that nvme requires the metadata buffer be physically
> contiguous, so user space will need to utilize huge pages if the buffer
> needs to span multiple pages.

I did not notice where this downside part is getting checked in the code.


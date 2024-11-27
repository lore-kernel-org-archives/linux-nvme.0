Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C49D6ACEF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 15:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M1qb8DkWFu6BUSzkOmk+azD9x6g/AwjObtKlBq0hAw8=; b=yQhYvYQEIpMwTF/tm2HvqvLJcW
	Glfa3c/RIOPRQxkvBe59h+OyXgcnhZteKtG3j9gz9aWFyvEhIZEiMgi7VRA8LZwWlkrP2n6AmH+mP
	MGvBi9oFm5KyJqwFEMe6IBVGtGqpqLO04SfEUBx5P7IqzX1S1tOT6fasPre8YUAKAFCYUF88vtEqh
	qxA+8fjLOWmby2qfmaW2Ryu7/NdpxvlKUTYr+b9DaDCkIyWXb+AAekdgl7GjnAx8XThVa/mutKuWp
	bHZ8XIC/yqFpqZg+bJPn5ezmuFLLZp3yyEv1bdxo72rjfhfjiK6j1p2n1gZQF8B6MK857OEJqLQRn
	Ez8A/Oyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGKS3-0000000DZe1-17Ng;
	Wed, 27 Nov 2024 15:59:39 +0000
Received: from [203.254.224.24] (helo=mailout1.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGKS0-0000000DZdT-26La
	for linux-nvme@lists.infradead.org;
	Wed, 27 Nov 2024 15:59:38 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241127155932epoutp0120db4428f50693ddadcccf456e275d27~L3ouB5d4q1711517115epoutp01O
	for <linux-nvme@lists.infradead.org>; Wed, 27 Nov 2024 15:59:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241127155932epoutp0120db4428f50693ddadcccf456e275d27~L3ouB5d4q1711517115epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1732723172;
	bh=M1qb8DkWFu6BUSzkOmk+azD9x6g/AwjObtKlBq0hAw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kOf6nnfQcuwd3tXfJm3YwF/kcD3MXzsDtPNJTvTmHz8G/ILHv3DsmF0u/rUogkd2I
	 UeGze1MLgGsh6nyNeoBqNAIh13TDJkGIIEn+HJtY0jkNmCeyQZbMzRIUYN1KWla4uT
	 hZRvpdtgh75FE/bhkieUcIc9p/5GZzPzAChZtK7I=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241127155931epcas5p2620bf0faf78d55bc2724c5fd262b50bd~L3os3uc6k0638006380epcas5p2N;
	Wed, 27 Nov 2024 15:59:31 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Xz3zQ0PNwz4x9Pp; Wed, 27 Nov
	2024 15:59:30 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C6.5A.20052.1E147476; Thu, 28 Nov 2024 00:59:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241127152849epcas5p3872af708d33fbfb00fd3b703b879b273~L3N5SYeeI3086430864epcas5p3w;
	Wed, 27 Nov 2024 15:28:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241127152848epsmtrp1d7c63beddd0f6b65d1db81db6b2d3191~L3N5M8fEC0820308203epsmtrp1O;
	Wed, 27 Nov 2024 15:28:48 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-67-674741e1b3af
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	40.77.18729.0BA37476; Thu, 28 Nov 2024 00:28:48 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241127152846epsmtip11d39dfad68f39164b6dbe589d3b31b8e~L3N3WFxp_1883018830epsmtip1n;
	Wed, 27 Nov 2024 15:28:46 +0000 (GMT)
Date: Wed, 27 Nov 2024 20:50:54 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, Saeed Mirzamohammadi
	<saeed.mirzamohammadi@oracle.com>
Subject: Re: [PATCH] nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES when DSM
 is not supported
Message-ID: <20241127152044.4lyezvphq5szu5f2@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20241127064218.42688-1-hch@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTU/eho3u6QfcPS4vVd/vZLFauPspk
	MenQNUaL+cueslssXX6M2WLd6/csDmwe5+9tZPG4fLbUY9OqTjaPzUvqPXbfbGDz+Pj0FksA
	W1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
	ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE
	7Ixfn8+wFMzhrPg/fwFrA2M/RxcjJ4eEgInEm4VdbF2MXBxCArsZJa5OX88E4XxilJh99j1U
	5hujxP+GRUwwLXe3LWIHsYUE9jJK7LnADFH0hFFi2o0NjCAJFgFViWdbHgE1cHCwCWhLnP4P
	tk5EQEni6auzjCD1zAJTGCW+HX/LAlIjLBAvcWiZNUgNL9D8q9f2skHYghInZz4BK+EUMJDo
	fykM0ioh8JZdovnwGXaIe1wkzjxezAphC0u8Or4FKi4l8bK/Dcoul1g5ZQUbRHMLo8Ss67MY
	IRL2Eq2n+plBbGaBDImG71eh4rISU0+tY4KI80n0/n4C9TyvxI55MLayxJr1C9ggbEmJa98b
	oWwPie67S6Ah1wwMlG3r2Scwys1C8tAsJPsgbCuJzg9NrLOAHmUWkJZY/o8DwtSUWL9LfwEj
	6ypGydSC4tz01GLTAsO81HJ4JCfn525iBCdMLc8djHcffNA7xMjEwXiIUYKDWUmEt4DbPV2I
	NyWxsiq1KD++qDQntfgQoykwfiYyS4km5wNTdl5JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLp
	iSWp2ampBalFMH1MHJxSDUzGpRNzBX6qux5lTv3CFf3lu/tEXaYTNf/0So/bllWx23e/nblW
	VvriPI8Fxoeytd+K55n0Lji+cEnoGtGyuF2TRSR9Av3Cudyfh2gmeOjtXt74xI9rXuV+Q4Mv
	CU1nUhMU1wUr+JfNmR+x6YfzWnUlOe7+5j3bM3mKxIqOimn+8fAsP+QVPTGnYvehK1ND9nUu
	eNAoNkFa99jSd1tDDSrCbYMNDvz7tv9AaV+bbu5c/dzoLvUSgZan7Y4sRl9P3paQnn6LYe+5
	75ckTDIdBBub/ev45f8mdF99vf3psQb1wDdZVz6pXG28XJB7VKXazC496eGGB8FfSw0TtZJ2
	bmr/rLvxbq1V3rKQDzv+K7EUZyQaajEXFScCALJNkcshBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSnO4GK/d0g542c4vVd/vZLFauPspk
	MenQNUaL+cueslssXX6M2WLd6/csDmwe5+9tZPG4fLbUY9OqTjaPzUvqPXbfbGDz+Pj0FksA
	WxSXTUpqTmZZapG+XQJXxtpLH1gKzrFVNE+bx97AeJu1i5GTQ0LAROLutkXsXYxcHEICuxkl
	Ll49xQ6RkJRY9vcIM4QtLLHy33OookeMEp0nH4ElWARUJZ5tecTUxcjBwSagLXH6PwdIWERA
	SeLpq7OMIPXMAlMYJdauvMMOUiMsEC9xaJk1SA0v0OKr1/aygdhCAvoSO2adZoGIC0qcnPkE
	zGYWMJOYt/khM0grs4C0xPJ/HCAmp4CBRP9L4QmMArOQNMxC0jALoWEBI/MqRsnUguLc9Nxi
	wwLDvNRyveLE3OLSvHS95PzcTYzgINfS3MG4fdUHvUOMTByMhxglOJiVRHgLuN3ThXhTEiur
	Uovy44tKc1KLDzFKc7AoifOKv+hNERJITyxJzU5NLUgtgskycXBKNTDpnhV3kmB8cMtIWGhJ
	kFbv+jlROpksiZFFSu6lMZet3pZJ91bM3vGUff2ttEUNk9aGPZJp85osPa2jT4b9SeXrmrWd
	ya4KzJbzw3VevVdPq5zX+ebNR6HtebdCJxfxAB18h/Ps/UkGn/zrAiqqHA79mblvQ1rF+msp
	tlsY/JdmB/3YrqO1M9duXcDkZcUTPIK2WoX4yEw8r1j8qDFOz++TxB0tq2VyjJmdBdfWltbX
	7PnLe0r91JdatjXpO9ZtZZFtej0v5blfb1o8Z/Ak/exNnOwzbqyq7rbsvTfT2qZ+k7qVrY7L
	nF8pj9onsX1+k3Qxwavu7bWNnXuuHbmtzv2o89f8m+x8Lqd2m/sqKLEUZyQaajEXFScCAD8w
	xprhAgAA
X-CMS-MailID: 20241127152849epcas5p3872af708d33fbfb00fd3b703b879b273
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_39f59_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241127152849epcas5p3872af708d33fbfb00fd3b703b879b273
References: <20241127064218.42688-1-hch@lst.de>
	<CGME20241127152849epcas5p3872af708d33fbfb00fd3b703b879b273@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_075937_004054_B99F5A4A 
X-CRM114-Status: GOOD (  12.70  )
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

------K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_39f59_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 27/11/24 07:42AM, Christoph Hellwig wrote:
>Commit 63dfa1004322 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of
>nvme_config_discard") started applying the NVME_QUIRK_DEALLOCATE_ZEROES
>quirk even then the Dataset Management is not supported.  It turns out
>that there versions of these old Intel SSDs that have DSM support
>disabled in the firmware, which will now lead to errors everytime
>a Write Zeroes command is issued.  Fix this by checking for DSM support
>before applying the quirk.
>
>Reported-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
>Fixes: 63dfa1004322 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard")
>Tested-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>---

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_39f59_
Content-Type: text/plain; charset="utf-8"


------K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_39f59_--


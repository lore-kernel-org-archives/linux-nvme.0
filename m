Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FB1C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 18:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y5OS7C3x4USZWkOHB+8ofntVAXK7uEdgUcFhqganpFk=; b=fvK3Lua5VASkXYvPJdFFQmrntz
	ernOnVb/6chlbTGQd7hDqxKmLI2Jv5y5Iu+adJZAlfUl85e+cae1hjDeRwFJgoGu3Ngx/bFkPDFhq
	VNBS75BgP8XX9Dt0PAKjEh6oql4QRGYZK/Q/zDqCAQVdvRAM7KTF+kD0xtOSc7ciaejjhqMc8rTSM
	MGtf+YB6xwzmgAemccZ8hkQyf/oWlpbql+fPPPnDX881s1ctY/vH+m/++WO7mMPNf9yZT1s5pCnKa
	gGhqA+3TLJXbJqZUtm4KITJ6TT5jftmZ5M1y/8eI7mZK/8LCiEM0QwX63cKigph2fGNRm9tqUXUMy
	ghr7fMPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njm6C-002tQD-9A; Wed, 27 Apr 2022 18:09:12 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njm60-002tMJ-FC
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 18:09:02 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20220427180858epoutp04e9a05176719b436505d217efeebaeff2~p0y86Id6N2665126651epoutp04M
 for <linux-nvme@lists.infradead.org>; Wed, 27 Apr 2022 18:08:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20220427180858epoutp04e9a05176719b436505d217efeebaeff2~p0y86Id6N2665126651epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1651082938;
 bh=y5OS7C3x4USZWkOHB+8ofntVAXK7uEdgUcFhqganpFk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=R8asHsPppiqdSNVTGyqE6JkdA3kfOs02eyF/ijaLLwIS9NRrripLZxPjCivOk0r7b
 hsSTjb7o7I0fJbDWr1kM61tgTa+NDfMX2kECOH+CRdOKPqyLRhlUMQvPpXbwW1voiE
 7pURtAOwqy0fn3Lu+uWJiXNJI72fldfEl1VryuTI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20220427180857epcas5p49214c5b087f6a3abc404d9e61d699270~p0y7zEIdM3093730937epcas5p4-;
 Wed, 27 Apr 2022 18:08:57 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4KpRZs2w2mz4x9Pq; Wed, 27 Apr
 2022 18:08:53 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 CB.2C.10063.5B689626; Thu, 28 Apr 2022 03:08:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20220427154335epcas5p2decfa46fd054003fe354919a6ccc8bb5~py0BFdT5t1292212922epcas5p2s;
 Wed, 27 Apr 2022 15:43:35 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220427154335epsmtrp1836aaec6d9081312a54cf44cfab35bf7~py0BEoafL2542225422epsmtrp1t;
 Wed, 27 Apr 2022 15:43:35 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-7e-626986b5bcd4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 B8.AA.08924.7A469626; Thu, 28 Apr 2022 00:43:35 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20220427154333epsmtip1c2203c795e44edd393049c9924cd6740~pyz-zoaVP2609826098epsmtip1D;
 Wed, 27 Apr 2022 15:43:33 +0000 (GMT)
Date: Wed, 27 Apr 2022 21:08:26 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Message-ID: <20220427153826.GE9558@test-zns>
MIME-Version: 1.0
In-Reply-To: <c02f67e1-2f76-7e52-8478-78e28b96b6a1@opensource.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmpu7Wtswkg77pgha/z55nttj7bjar
 xd5b2hZ79p5ksbi8aw6bxfxlT9ktuq/vYLPY8aSR0YHDY+esu+wem5fUe+xsvc/q8X7fVTaP
 z5vkAlijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJz
 gC5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgY
 mQIVJmRn/LohVnBRoOL4pJPMDYzXebsYOTkkBEwkdvY9Yuli5OIQEtjNKPHm919GCOcTo8Sa
 bb2sEM5nRolFe6eywLS8Xj8LqmoXo8S7d1+gnGeMEtNP/gKrYhFQlZh4dCV7FyMHB5uAtsTp
 /xwgYREBU4m3Pa1g+5gFzjBKtL/fxQ6SEBYwk1jd2coGYvMK6Eg8n32TFcIWlDg58wkLyBxO
 ATeJXSuVQMKiAsoSB7YdZwKZIyEwlUPi76E/TBDXuUgseb2IGcIWlnh1fAs7hC0l8bK/Dcou
 l9jetgCquYVRouvUKajX7CUu7vkLNohZIEPizftlUA2yElNPrYOK80n0/n4CtYxXYsc8GFtZ
 Ys36BWwQtqTEte+NULaHxM6PK6HheIpR4tmkBtYJjPKzkDw3C8m+WUCPMgtoSqzfpQ8Rlpdo
 3jqbGSIsLbH8HweSigWMbKsYJVMLinPTU4tNCwzzUsvhkZ+cn7uJEZxotTx3MN598EHvECMT
 B+MhRgkOZiUR3i+7M5KEeFMSK6tSi/Lji0pzUosPMZoC420is5Rocj4w1eeVxBuaWBqYmJmZ
 mVgamxkqifOeTt+QKCSQnliSmp2aWpBaBNPHxMEp1cA07bdN1pr1rOJuT7VLfALK9OTWfT79
 2k7qzV7JTcov07ez1cwpjd/Zprt8Sdykh99eBecX7HR1PmOy9omaz7lYLsFdvAfuvKqdavCo
 77T2y1O3HAMM3t6atKFmfUyeZTYfR5Dq9M6CZQHJOpMs5iQw/AmTTXpnrfdn8dWV/0/2Ck/9
 zn/x2KsAs0fblQV7w+8JRPGnXFLi4fBf+NbXzGe63MoCg8VbnqXf+H/t0vG+5Jw5LN7BKrdc
 YmUXrb3KcOXp2hkTlk5WE3Cs/6TI++yOy66S1RuPGqY6LF25+nvDn8XJX6POqU7a7pvFLO2X
 P/uAXOr6bd4Mbnbz5wTk3Ymv4M4L/+nf/pbxR36mj2+pEktxRqKhFnNRcSIAhY8t5z0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnO7ylMwkg54+LovfZ88zW+x9N5vV
 Yu8tbYs9e0+yWFzeNYfNYv6yp+wW3dd3sFnseNLI6MDhsXPWXXaPzUvqPXa23mf1eL/vKpvH
 501yAaxRXDYpqTmZZalF+nYJXBnrr39gLPjMWzHvxASWBsap3F2MnBwSAiYSr9fPYuxi5OIQ
 EtjBKLFszhU2iISkxLK/R5ghbGGJlf+es0MUPWGUmHllNyNIgkVAVWLi0ZVACQ4ONgFtidP/
 OUDCIgKmEm97WllA6pkFzjBKtL/fxQ6SEBYwk1jd2Qq2gFdAR+L57JusEENPMUq8vDyZCSIh
 KHFy5hMWEJtZQF3iz7xLzCALmAWkJZb/44AIy0s0b50NFuYUcJPYtVIJJCwqoCxxYNtxpgmM
 QrOQDJqFZNAshEGzkAxawMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOHK0tHYw
 7ln1Qe8QIxMH4yFGCQ5mJRHeL7szkoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5Y
 kpqdmlqQWgSTZeLglGpgsjqyIrdo7svg/Yd2r1/Vz3s9JMRNZlmiaxt/6tsXvfcmmR+85KSo
 8Cmub7Fk87R1E+ZdS86dUxIwbyfTztmSc94JtpRP6T5xaIPvvbMbb4oUFmftuZ3SwaC1n/kv
 W1rtJrsi++RZ6x0iFboPbiiz2PQ+9O3GN7+6pB5bzJf7080Uv6dhEdNVixczPm8VYCmYzv7t
 X0zu1fkf/vX1HV3dNaujOHdJL+v5JO7mkunK6oJnZ+Xt2m71eUXHV98ZZbvqdOq8FzgUuWZo
 ZZm6SoRpvTpsvFz/BDv/VKfXGUtEDi0Myw5lDvrdXMyoN+XK+na3XWtrpLbIZze6nqs5oRxy
 +NmFf8Zn1qv7Lf0k1O4cpcRSnJFoqMVcVJwIAL0nILoLAwAA
X-CMS-MailID: 20220427154335epcas5p2decfa46fd054003fe354919a6ccc8bb5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----SFNbypxiwiYv2mFj5qNI3mkL0EyMW--LFKYa8svGKq9OOQ6W=_17deb_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <c02f67e1-2f76-7e52-8478-78e28b96b6a1@opensource.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_110900_929411_7D0DE3D8 
X-CRM114-Status: GOOD (  22.35  )
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

------SFNbypxiwiYv2mFj5qNI3mkL0EyMW--LFKYa8svGKq9OOQ6W=_17deb_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Wed, Apr 27, 2022 at 10:46:32AM +0900, Damien Le Moal wrote:
> On 4/26/22 19:12, Nitesh Shetty wrote:
> > The patch series covers the points discussed in November 2021 virtual call
> > [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
> > We have covered the Initial agreed requirements in this patchset.
> > Patchset borrows Mikulas's token based approach for 2 bdev
> > implementation.
> > 
> > Overall series supports –
> > 
> > 1. Driver
> > - NVMe Copy command (single NS), including support in nvme-target (for
> >     block and file backend)
> > 
> > 2. Block layer
> > - Block-generic copy (REQ_COPY flag), with interface accommodating
> >     two block-devs, and multi-source/destination interface
> > - Emulation, when offload is natively absent
> > - dm-linear support (for cases not requiring split)
> > 
> > 3. User-interface
> > - new ioctl
> > - copy_file_range for zonefs
> > 
> > 4. In-kernel user
> > - dm-kcopyd
> > - copy_file_range in zonefs
> > 
> > For zonefs copy_file_range - Seems we cannot levearge fstest here. Limited
> > testing is done at this point using a custom application for unit testing.
> 
> https://protect2.fireeye.com/v1/url?k=b14bf8e1-d0361099-b14a73ae-74fe485fffb1-9bd9bbb269af18f9&q=1&e=b9714c29-ea22-4fa5-8a2a-eeb42ca4bdc1&u=https%3A%2F%2Fgithub.com%2Fwesterndigitalcorporation%2Fzonefs-tools
> 
> ./configure --with-tests
> make
> sudo make install
> 
> Then run tests/zonefs-tests.sh
> 
> Adding test case is simple. Just add script files under tests/scripts
> 
> I just realized that the README file of this project is not documenting
> this. I will update it.
>

Thank you. We will try to use this.
Any plans to integrate this testsuite with fstests(xfstest) ?

--
Nitesh Shetty

------SFNbypxiwiYv2mFj5qNI3mkL0EyMW--LFKYa8svGKq9OOQ6W=_17deb_
Content-Type: text/plain; charset="utf-8"


------SFNbypxiwiYv2mFj5qNI3mkL0EyMW--LFKYa8svGKq9OOQ6W=_17deb_--


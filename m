Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18657FA3722
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 07:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3zqtpJE/mdk5d0QMfgH8EkNrmbkSOpNb4bGq/RkfojY=; b=3DT1FIH6DfmQsahBFuZDM+NyJn
	0qmWGoKS77im6jzVPkDkmHXfUwXeqcykPLX37TV4ycfKyeImHbKZbsprTMNswM2xqUw3zAbGAlLkt
	lgnj9DxkSuzWNnz/p9Ap269WVhfTf0J8MPMHaYLVc9G6yZ+6rA/fRC3JnhQQHd+3tEA0/e5lZB5R4
	2YhVn+34/Hp4rUcWkIy92Ps6xR1Ba2TgvybVTDo2yIa2pZ0ekXThIKEinWrPuUwpBEORjG/ZGjSXp
	EOA3EexF+NHWeg5lbrPVxQoHE5DdS3/tdUfd9z3yC0g8D2Ic0NFlx4fdeS+wuA1D1rx2QI0ZmC3z1
	O0K9p12A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp0XK-0000000F84r-2Lzj;
	Fri, 13 Sep 2024 07:16:10 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp0XB-0000000F82w-1J4J
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 07:16:06 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240913071552epoutp049e32b842778cf00d6a4be9cc7dfbaae3~0vHF7DEKd1103911039epoutp04Q
	for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 07:15:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240913071552epoutp049e32b842778cf00d6a4be9cc7dfbaae3~0vHF7DEKd1103911039epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726211752;
	bh=3zqtpJE/mdk5d0QMfgH8EkNrmbkSOpNb4bGq/RkfojY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ORtlmQjVsW2YhXgfkmG/5bxOhjsKBtoesB9TnM9kkrMggSgzuuk5thhsWSXwKcY35
	 VzH/pen3oMAEEogfXtS5X2UUN69eHuG3IQfaBtO6okL9E4pPUYr1qKo9Bm1S9llSP/
	 6NqsaFlQ/cTCVDZ3qDh//ErbKg3CYy3BWygw7ZUs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240913071552epcas5p407bc7471dba9c401717e052479b00d1a~0vHFg4og41690216902epcas5p41;
	Fri, 13 Sep 2024 07:15:52 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4X4lvq1M23z4x9Ps; Fri, 13 Sep
	2024 07:15:51 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	62.03.19863.7A6E3E66; Fri, 13 Sep 2024 16:15:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240913071550epcas5p105ccc2bbc82283e49e07d5dff05020b0~0vHEENaJk1486314863epcas5p1j;
	Fri, 13 Sep 2024 07:15:50 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240913071550epsmtrp1178989a849662704336e4812401c84a6~0vHEDG6WC1969919699epsmtrp1W;
	Fri, 13 Sep 2024 07:15:50 +0000 (GMT)
X-AuditID: b6c32a50-ef5fe70000004d97-dd-66e3e6a77a65
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	49.15.19367.6A6E3E66; Fri, 13 Sep 2024 16:15:50 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240913071547epsmtip1be43924e78b5b0a33230ca2b73f0bf33~0vHBFfCZz3168031680epsmtip1q;
	Fri, 13 Sep 2024 07:15:47 +0000 (GMT)
Message-ID: <19f3205e-ba37-0541-f8ac-4e0fc8fcee87@samsung.com>
Date: Fri, 13 Sep 2024 12:45:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v5 3/5] fcntl: add F_{SET/GET}_RW_HINT_EX
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	jlayton@kernel.org, chuck.lever@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <53043e99-be5f-4fc6-be87-4ebcb8ce99b6@acm.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xbVRTHfe+V1wdSfStj3HQG6jObDAa0E+qF8WPJ2HwRTJjoHxInPumD
	kpa26Y+xmRIJBJSp4CoO7BgwJEAh4UdBws+IZYZNIF1gbkIANyglo5AJmExEmC1lk/8+59zz
	vd9z7sklMH4JV0BkK3WsRskoKNyH0z18LCSs0bGQKRpa8YIts2U4dA6vI/Dqn5sYfDq7hMKp
	oV4Umlt+QeG1ikIU2ttMGOwoI+DCzAYXbjY0c6HReg+Bg9OhcKLuLTgweJsDaxoWufDL+z04
	bBzZQWH3Vg0GW52POdC2PeIFbaYq7qlD9OTdJNo218Ghrxp/xenJcT1taS7B6c76z+j+2g2U
	7p/Kx+m1xWkOXdrVjNBjtTe59IYlkLbYV9EUXpo8VsYyUlYjZJUZKmm2MiuOSkpNP50eJRGJ
	w8TR8E1KqGRy2DgqMTkl7Gy2wjUzJbzAKPSuVAqj1VIR8bEalV7HCmUqrS6OYtVShTpSHa5l
	crR6ZVa4ktXFiEWiE1Guwo/lss2qakxtOXCxoXvAKx9p4l1GvAlARoKaQSNyGfEh+OQAAlpn
	nnI9wToCClds2PNgsWAYeSb57ucV1HPQi4D6sbo9/SoCRueWMHcVj4wHtpkq1M0c8ggYnzfj
	nvwBcPt7O8fN/uQn4J/fqnZv9SPjwI3tJq6bMTIATNtrdrUHyXYUTBT5uA0wshwFf1daXQYE
	gZPHwJ1v9e4ab/Ik+MnRgXu0QaDwx2u7bQOy0RsMdK2jnrYTQXHfENfDfmB5pGuPBeBRWfEe
	y8GD+QccDxtAT2epl4cTQP6/v3u5fTGXb1tfhMfrJfD1lh11pwHJA18U8z3Vr4I54+KeMgA8
	rKzfYxpMl9/dbZNPLiOg+dHRbxChad+rmPZNb9o3jel/41qE04wIWLU2J4vNiFKLw5Rs7vON
	Z6hyLMjunwhJ6UFa2rfDrQhKIFYEEBh1kGfE5zP5PClz6VNWo0rX6BWs1opEufZzBRP4Z6hc
	n0qpSxdHRosiJRJJZPQbEjEVwHMWXZfyySxGx8pZVs1qnulQwluQjwp1RUV3Lt5iE6IHE62K
	98+Mhppnix76+/W+LNOwwYZzH2EZt1KPRztr8/A+Y+6Rw7phUUROtSPoftIVH19DY+YfT8aO
	RggFjC6NsoTcKxdICj+/cMY+er7aqmiSZYev2sYzidHYQEfYYY5E65TnfTVxKfOGfPL4277v
	GCqkQsNW6an+usQfkoNK+z5QhMhLXlxjix1M8qaS2xaDC6D5vcfXJWvtAXmnO1UNxFmnrZ8x
	fDgaPDSWMPVC4F+doa9Ta+fOR7WmVqIV1nfHJyfKIibMhwqSHB2vccxbg/xK37TTJ+KXCm4+
	GRqWru5sJZ98JSZ4LCg7d2ehdhl2mcZrKI5WxohDMI2W+Q+MMFVlnAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjuO+fs7GgMjjPz6x4TIxM1JeyjUqKiDhUV3a/Y1OMy51xbywqi
	lRW5Loqa1tGcpcym5GW5qamUlxJHsrykKWqoU0MtKymV0NVcgf+e931u74+XwoW9xGIqUnae
	VcjEUhHpTJhqRct9dIP9EWvNJR4ovzuBRCO1PwBK/TaFI1v3EIY6XpdjSJ//BkPpaXEYshZy
	OCpOoFB/1zgfTeny+Cippg2gqk5v1Px0B6qsaiCQVjfAR3fay0iUWz+DIdNvLY4KRsYIZJmu
	5yELl8HfvJBpad3FWHqKCSY1yUwyLY0qxpAXTzIvcq4yFVnjGFPRoSaZ7wOdBHO/JA8w77Lq
	+My4YTljsH7B9gmOO28KZ6WRF1iFX/Bp5zNTGZm43OByUWeq5KnBM4EGOFGQXgcfVI9iGuBM
	CelSAHNmynEH4Q7j2ib5DuwK9TNDfIdoBMDkni7STgjoYGjpysDsmKA9YWOf/t/eBTY8shJ2
	7EaHwspP12Y1rnQQfDL9bDYU/1vQadXO7hfQRRicbF5pL8DpFAyO3Bj71zYMYLo58e9AUSTt
	Bd8nq+wGJ3ojfDVYTDqCAqHGqAEOvALGGdPxRCDk5tzBzenj5li4OZYsQOQBN1aujJZEh8n9
	fZXiaKVKJvENi4k2gNkvWLO/DOgKp31rAEaBGgApXLRAkET2RQgF4eJLl1lFTIhCJWWVNWAJ
	RYjcBR7S+HAhLRGfZ6NYVs4q/rMY5bRYjXlfv+4nVdUZj028m/5q+rx9p+Q37eLzy/OQzZLc
	5ttwGNcdPHry6t269QMfOz9fkfO0H/X9r0cFyzCbrEp7bnPznu+8oMl7sLepaT4vzctb/rOL
	G7zSvWXD1+bYwFhzQW2f9UGtWh864cUTWRM8Yqc+7VXdydrIe9su+5BqdC048jiqY3dfC3O5
	qPdWSV117s3qbQGaipbKH8EB8yX97W/ygzJPrPZ8OFBifhySOJHNXfSf57HM1KReui1txyLz
	vvZfN75k25rGYlaNP/WxoSXD7n5jpYk7h1uvZdbnjBaJzSk9k/TEgSdFxSZj/K3bZ5/fOyUH
	5WnVloiXdzls61BhiohQnhH7r8EVSvEffHF713QDAAA=
X-CMS-MailID: 20240913071550epcas5p105ccc2bbc82283e49e07d5dff05020b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af
References: <20240910150200.6589-1-joshi.k@samsung.com>
	<CGME20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af@epcas5p4.samsung.com>
	<20240910150200.6589-4-joshi.k@samsung.com>
	<53043e99-be5f-4fc6-be87-4ebcb8ce99b6@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_001602_042192_B8E14E5E 
X-CRM114-Status: GOOD (  14.74  )
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

On 9/13/2024 2:06 AM, Bart Van Assche wrote:
> On 9/10/24 8:01 AM, Kanchan Joshi wrote:
>> diff --git a/include/linux/rw_hint.h b/include/linux/rw_hint.h
>> index b9942f5f13d3..ff708a75e2f6 100644
>> --- a/include/linux/rw_hint.h
>> +++ b/include/linux/rw_hint.h
>> @@ -21,4 +21,17 @@ enum rw_lifetime_hint {
>>   static_assert(sizeof(enum rw_lifetime_hint) == 1);
>>   #endif
>> +#define WRITE_HINT_TYPE_BIT    BIT(7)
>> +#define WRITE_HINT_VAL_MASK    (WRITE_HINT_TYPE_BIT - 1)
>> +#define WRITE_HINT_TYPE(h)    (((h) & WRITE_HINT_TYPE_BIT) ? \
>> +                TYPE_RW_PLACEMENT_HINT : TYPE_RW_LIFETIME_HINT)
>> +#define WRITE_HINT_VAL(h)    ((h) & WRITE_HINT_VAL_MASK)
>> +
>> +#define WRITE_PLACEMENT_HINT(h)    (((h) & WRITE_HINT_TYPE_BIT) ? \
>> +                 WRITE_HINT_VAL(h) : 0)
>> +#define WRITE_LIFETIME_HINT(h)    (((h) & WRITE_HINT_TYPE_BIT) ? \
>> +                 0 : WRITE_HINT_VAL(h))
>> +
>> +#define PLACEMENT_HINT_TYPE    WRITE_HINT_TYPE_BIT
>> +#define MAX_PLACEMENT_HINT_VAL    (WRITE_HINT_VAL_MASK - 1)
>>   #endif /* _LINUX_RW_HINT_H */
> 
> The above macros implement a union of two 7-bit types in an 8-bit field.
> Wouldn't we be better of by using two separate 8-bit values such that we
> don't need the above macros?

I had considered that, but it requires two bytes of space. In inode, 
bio, and request.
For example this change in inode:

@@ -674,7 +674,13 @@ struct inode {
         spinlock_t              i_lock; /* i_blocks, i_bytes, maybe 
i_size */
         unsigned short          i_bytes;
         u8                      i_blkbits;
-       u8                      i_write_hint;
+       union {
+               struct {
+                       enum rw_liftime_hint lifetime_hint;
+                       u8 placement_hint;
+               };
+               u16 i_write_hint;
+       };

With this, generic propagation code will continue to use 
inode->i_write_hint. And specific places (that care) can use either 
lifetime_hint or placement_hint.

That kills the need of type-bit and above macros, but we don't have the 
two bytes of space currently.


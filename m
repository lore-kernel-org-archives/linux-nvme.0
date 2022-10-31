Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE6BECAAA1
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Oct 2022 13:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F6eIvgDNVItLevUhdPY4P5ZFwr7uZVtkRFcW6BYqf6w=; b=sCm8N3dI6ABqqiM5GfxVgpS7vn
	whpy09BGazoXsBrZxVdU3pJvuiRQiTzJIlhb1XcoQdYb5yUZuRykTp5qtCjwdaDmBnGCxNIOKbxmw
	xcaBIlIKygZ/ze50Q/nRarqNNOLmchQgTXFJ4+KCavDUXEPyR7nlO1yGOqb8uouTYoP56BOpBctEB
	jgwrSMXMoyz/DcP+tSR55z0lkAzi2mS+3T30CyX+Fz32hCARdUnloT2vd8F+wQfX4WLFhOEPIToo0
	xLcpaSSiFq3aKFSXbqSETUlEtKfvkeMi5Q2SJlyrag9F3lvo4PtPLZbmnH55/085lodTjC5/cZQhX
	YIWts3VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opVKH-00CB7W-ET; Mon, 31 Oct 2022 13:59:41 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opVK8-00CB2d-DH
	for linux-nvme@lists.infradead.org; Mon, 31 Oct 2022 13:59:39 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221031135920epoutp024db1804e4c776321e3174e09c1cfbbbb~jLBYPeGVR2166821668epoutp02o
	for <linux-nvme@lists.infradead.org>; Mon, 31 Oct 2022 13:59:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221031135920epoutp024db1804e4c776321e3174e09c1cfbbbb~jLBYPeGVR2166821668epoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1667224760;
	bh=F6eIvgDNVItLevUhdPY4P5ZFwr7uZVtkRFcW6BYqf6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FjVxpAMqizIeJtc7rqUp9CMdgbS+oX7t4LA1up89cnkpneZi/whlXaPIULzm/fwjm
	 G/UOpHnjwQfVUK3Smeb/nOkuFzjT//hu0TJ1ph8t/0WPu25rgP3fixK1pmnnwPf7Uk
	 c1uNDC2rQa/ZccrAEhy1Qc60mIUcPH8h6UNXDsyQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20221031135920epcas5p3362e253fd259b8807b4b657d86a8c969~jLBYE5kel0706407064epcas5p3I;
	Mon, 31 Oct 2022 13:59:20 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4N1FBY3Pvlz4x9Pq; Mon, 31 Oct
	2022 13:59:17 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E3.6C.39477.4B4DF536; Mon, 31 Oct 2022 22:59:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20221031135916epcas5p281da1bded241fd3718e51a5a0e876f61~jLBUTq-VN2329423294epcas5p2r;
	Mon, 31 Oct 2022 13:59:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221031135916epsmtrp21439ca7f537d148820c096376c04d925~jLBUS_J4I2215822158epsmtrp2Y;
	Mon, 31 Oct 2022 13:59:16 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-8c-635fd4b43f20
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	24.B5.14392.3B4DF536; Mon, 31 Oct 2022 22:59:15 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20221031135914epsmtip1fd726ba10bc8018cbaf4e216110dea0d~jLBS763Nw2927629276epsmtip1k;
	Mon, 31 Oct 2022 13:59:14 +0000 (GMT)
Date: Mon, 31 Oct 2022 19:17:59 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH 2/2] nvme: identify-namespace without CAP_SYS_ADMIN
Message-ID: <20221031134759.GA20135@test-zns>
MIME-Version: 1.0
In-Reply-To: <737c7d72-ff5e-1f0e-304c-24bbb23f30a1@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmuu6WK/HJBld/GFmsvtvPZvH+4GNW
	i5sHdjJZrFx9lMli0qFrjBbzlz1lt1j3+j2LA7vH+XsbWTwuny312LSqk81j85J6j903G9g8
	epvfsXn0bVnFGMAelW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
	4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8v
	tcTK0MDAyBSoMCE74+6p3+wF00Qr2s6uZW5gvMHfxcjJISFgIrHm1k6WLkYuDiGB3YwScxd/
	YANJCAl8YpRYfDQNwv7GKHFnchBMw87Wk6wQDXsZJW5f28EI4TxjlNj19TszSBWLgKrElfW/
	mLoYOTjYBDQlLkwuBQmLCOhJXL11gx2knlmgi0lixcUtTCAJYQF3ibm3NrKD2LwCuhKf/txg
	hrAFJU7OfMICYnMK2EnMn/ECzBYVUJY4sO04E8ggCYGJHBILeg+wQpznInHuF8QREgLCEq+O
	b2GHsKUkPr/bywZhJ0tcmnmOCcIukXi85yCUbS/ReqofrJdZIF3iSf8sJgibT6L39xOwZyQE
	eCU62oQgyhUl7k16CrVWXOLhjCVQtofE85510CB9zyjxqHkG4wRGuVlI/pmFZAWEbSXR+aGJ
	dRbQCmYBaYnl/zggTE2J9bv0FzCyrmKUTC0ozk1PLTYtMMpLLYfHcXJ+7iZGcArV8trB+PDB
	B71DjEwcjIcYJTiYlUR4689GJwvxpiRWVqUW5ccXleakFh9iNAXGz0RmKdHkfGASzyuJNzSx
	NDAxMzMzsTQ2M1QS5108QytZSCA9sSQ1OzW1ILUIpo+Jg1OqgWmGbmCMa5WLBYfqlg/3d/9b
	XVIW+7zH5v4T+Ud/tJYb+xsLvPqdXHtI9J1xvMVX++aMgIn7xNQzFjjfWNfLOU/ivmqEcXTd
	5gPcSgpSL1emr7cSOH3tfFcEA4udte4fdvOwGyusJtWlL9gjuY1T5eiTWxvjHGftU46sXpVU
	+31i3O+C/JO/97X+kDnHs2RDQszELTfZl+zKmcpafXZpPD/nkfSZcTfTd93ueh9TcUpq67+v
	lw+5L3fcqPjxZcKO9xw5PDO87fpjfxWVKjN/qg5Zss/8P+NhY/8/215t6tiwOND0ckmaZ8s1
	JsfyE4/UZ3+eyPPS7cXSfxfmSQSJvpj5YfXF099ttph0Fy44UHZXiaU4I9FQi7moOBEAbNIW
	mioEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSnO7mK/HJBgsnWVmsvtvPZvH+4GNW
	i5sHdjJZrFx9lMli0qFrjBbzlz1lt1j3+j2LA7vH+XsbWTwuny312LSqk81j85J6j903G9g8
	epvfsXn0bVnFGMAexWWTkpqTWZZapG+XwJWxbN8Z1oLTQhX/+2+wNDAu5+1i5OSQEDCR2Nl6
	krWLkYtDSGA3o8TFF1vZIRLiEs3XfkDZwhIr/z1nhyh6wijxdtYrFpAEi4CqxJX1v5i6GDk4
	2AQ0JS5MLgUJiwjoSVy9dQOsnlmgh0ni39JVTCAJYQF3ibm3NoIN5RXQlfj05wYziC0k8J5R
	Yv5+YYi4oMTJmU/A5jMLmEnM2/yQGWQ+s4C0xPJ/HCBhTgE7ifkzXoCViAooSxzYdpxpAqPg
	LCTds5B0z0LoXsDIvIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzgqtDR3MG5f9UHv
	ECMTB+MhRgkOZiUR3vqz0clCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0t
	SC2CyTJxcEo1MLVpR18wN4uX2bCjsfTvZuHKv7tnbkrT3Vz3KdbMQ+tad9ZKqT6TrWbuHi+9
	njVWrbl8fF5I8m/HE4k70w5tC7CszfIXcL1YM0GQxXXBxfVLPz3WPu28+aG18vVlieyrl058
	xCJ5ILcl66bsCqPn5etLGK6YhJ3xvrRTQpnj9LruZ1eZb7ZE2X67mRApVP6Th4HzpsnH9bvM
	/wjGTeUtmHJz+3GNl84prbsD/ZLVtlbuby05qa6UJFD+tnWL98/ze5gW1E7RETd9URy5+tOr
	XuX/0cYPDvtL7PZ4P0Fk+4oJ7+ZK2io1+8RmlCcvSEvMS/699cWLl9avr72qbBW47FdjeWlJ
	9mnW6sa+j6/OfVNiKc5INNRiLipOBAAg+GgU+QIAAA==
X-CMS-MailID: 20221031135916epcas5p281da1bded241fd3718e51a5a0e876f61
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_760c_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221020071346epcas5p4c3b8da5e60f94947ad570cbd151eb38d
References: <20221020070205.57366-1-joshi.k@samsung.com>
	<CGME20221020071346epcas5p4c3b8da5e60f94947ad570cbd151eb38d@epcas5p4.samsung.com>
	<20221020070205.57366-3-joshi.k@samsung.com>
	<737c7d72-ff5e-1f0e-304c-24bbb23f30a1@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_065933_945589_3221C1CE 
X-CRM114-Status: GOOD (  20.84  )
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

------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_760c_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Mon, Oct 31, 2022 at 06:55:56AM +0000, Chaitanya Kulkarni wrote:
>On 10/20/22 00:02, Kanchan Joshi wrote:
>> Allow all identify-namespace variants (CNS 00h, 05h and 08h) without
>> requiring CAP_SYS_ADMIN. The information (retrieved using id-ns) is
>> needed to form IO commands for passthrough interface.
>>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> ---
>>   drivers/nvme/host/ioctl.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>> index 9c581b1a8956..9273db147872 100644
>> --- a/drivers/nvme/host/ioctl.c
>> +++ b/drivers/nvme/host/ioctl.c
>> @@ -15,9 +15,19 @@ bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c, fmode_t mode)
>>   	if (capable(CAP_SYS_ADMIN))
>>   		return true;
>>
>> -	/* admin commands are not allowed */
>> -	if (!ns)
>> +	/* policy for admin commands */
>
>above comment is not needed as it is clear from the opcode below
>you are dealing with admin commands only that too specific cns
>values ..
>
>> +	if (!ns) {
>> +		if (opcode == nvme_admin_identify) {
>> +			switch (c->identify.cns) {
>> +			case NVME_ID_CNS_NS:
>> +			case NVME_ID_CNS_CS_NS:
>> +			case NVME_ID_CNS_NS_CS_INDEP:
>> +				return true;
>> +			}
>> +		}
>> +		/* other admin commands are not allowed */
>
>same here..

All right, will kill these. 
>
>>   		return false;
>
>if and swicth and two returns are looking confusing, I'd use
>nested switch case default here..

Do you think that'll give better looking code?
I did not write that because it did not seem good fit for the
situtation. It involved aligning more curly braces: 

-       /* admin commands are not allowed */
-       if (!ns)
+       if (!ns) {
+               switch (opcode) {
+               case nvme_admin_identify: {
+                       switch (c->identify.cns) {
+                       case NVME_ID_CNS_NS:
+                       case NVME_ID_CNS_CS_NS:
+                       case NVME_ID_CNS_NS_CS_INDEP:
+                               return true;
+                       }
+               }
+               }
                return false;
+       }

Above is without default. And with two defaults, it just gets more
wordy.
And future growth in above admin opcodes is not expected too.

------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_760c_
Content-Type: text/plain; charset="utf-8"


------GsYAgckb8ZPIB7TqR4NYyp-jgnPv5c.LE-kW9H5hDU_d1TDU=_760c_--


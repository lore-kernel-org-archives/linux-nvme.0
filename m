Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0473C07E95
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 15:35:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3DCB613E3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 15:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DCB613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5MCOyMwPoLoTu4BF5OPc+1zyfhZ+UFpX2gWbRgIjR/I=; b=lj8jbmq2P+M7krrsOvzVevmLWH
	yURZH0q4xp4BevblzI3qVrYNzZ+bsEgX6IbwdRyMwy73v8TuSwmT94VYu7EJlim1108HZxSy4Ueji
	WmMhgT38Di+7QOWJei7oBy7Ko+rVyn9YvGpS/Ucd3ijkTpOuXsbwl5lXarypjz1jg2ts8NBWSo/49
	SXW9vOgQvHNNFQivw94LZ5NV7BnIZ3L5HZO0M1B8uzOahVXQfnSP/KzwbliN9W5ZnmPipcqK//uJF
	HeDuuJop0UEwmgaOfL4tpyFHXUmODxKUed40YVZbcVt0KhenucETaNmrFKo2U9YqdI+cl7rW2iCFz
	YyIMy/MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5VIx-00A87D-Lk; Mon, 19 Jul 2021 15:35:39 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5VIk-00A85u-UR
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 15:35:28 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20210719153521epoutp033df7922771d257aed7c4c9d8e60e8c00~TOyUwv3Ua2388223882epoutp03b
 for <linux-nvme@lists.infradead.org>; Mon, 19 Jul 2021 15:35:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20210719153521epoutp033df7922771d257aed7c4c9d8e60e8c00~TOyUwv3Ua2388223882epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1626708921;
 bh=+iz8QLjyp62ci/sHv6Gd+OoD0wpySUqvhfTJiDKOEtA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tVgY/G0IaQc4pq/Bm0tjsQVcQqmCxFy53mEW1ftR5Z2mMbDqSSjGhz/t0X6AY2PU6
 U89kLQBkZExcWths1BaHoSeKUy/IX+aYy0+wfMVLhvgEDId+Y6or7F7lruiVGnTZQQ
 K9zh0B/815axp02ZxKAJNybJDRwXQbz/poyr7+O8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20210719153520epcas5p20f884d337a3c9f5a59fc0bc068123874~TOyUDQcmK3131731317epcas5p2f;
 Mon, 19 Jul 2021 15:35:20 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.196]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4GT5Wp5g17z4x9Pv; Mon, 19 Jul
 2021 15:35:18 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 38.7B.55882.6BB95F06; Tue, 20 Jul 2021 00:35:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20210719153248epcas5p129bcb1396231522b157d4399ff3ed7f0~TOwG5BO-H2542925429epcas5p1f;
 Mon, 19 Jul 2021 15:32:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210719153248epsmtrp2ce3b6917190a17f96a6234ca3669b9c0~TOwG48far2068720687epsmtrp2I;
 Mon, 19 Jul 2021 15:32:48 +0000 (GMT)
X-AuditID: b6c32a49-f4fff7000001da4a-fd-60f59bb6aa4d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 80.90.08289.12B95F06; Tue, 20 Jul 2021 00:32:50 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20210719153247epsmtip10c4214f73775976dd53b5bc0b1fc8bf2~TOwFGS7Dg2100021000epsmtip1g;
 Mon, 19 Jul 2021 15:32:46 +0000 (GMT)
Date: Mon, 19 Jul 2021 21:01:41 +0530
From: Mohit Kapoor <mohit.kap@samsung.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, qemu-devel@nongnu.org,
 its@irrelevant.dk, stefanha@redhat.com, fam@euphon.net, kwolf@redhat.com,
 mreitz@redhat.com, qemu-block@nongnu.org, k.jensen@samsung.com,
 p.kalghatgi@samsung.com, javier.gonz@samsung.com, prakash.v@samsung.com,
 d.palani@samsung.com, u.kishore@samsung.com, jg123.choi@samsung.com
Subject: Re: [RFC PATCH nvme-cli 2/2] nvme-cli/plugins/mi:add support
Message-ID: <20210719153141.GA28218@test-zns>
MIME-Version: 1.0
In-Reply-To: <20210709160430.GB291156@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmhu622V8TDJb/MbB4+/UBm8WV/ecZ
 LfYf/MZq8fjOZ3aLpfP1LU427mG1mHToGqPFkoupFvOXPWW3mHdL2eL6z0fsFlemLGK2mPWu
 nc3ieO8OFovXk/6zWtxsfsrmIODx41w7m8e5HefZPTat6mTz2Lyk3uPJtc1MHu/3XWXz6Nuy
 ijGAPSrHJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfo
 dCWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgaFRgV5xYm5xaV66XnJ+rpWhgYGR
 KVBlQk7G8Y4JrAXrhCt2PV7P0sC4hK+LkYNDQsBEYsr9/C5GLg4hgd2MEv+eHGSHcD4xSjzY
 tokJwvnMKLFs9m2WLkZOsI6tDZdYIRK7GCWOTDjACJIQEnjGKHGoUwfEZhFQlVj7bRtYnE1A
 S2LW4f/MILaIgLLE3fkzwZqZBW4ySax6dZ4d5A5hAVeJiz+zQWp4BXQldvdeYIOwBSVOznwC
 tphTwEli/7QeJhBbFGjOgW3Hwa6TEDjDIXFt6zk2iH9cJNbPk4A4VFji1fEt7BC2lMTnd3uh
 SqolZq3jhWjtYJRY0HeWDaLGXuLinr9g85kFMiT27J/DCBGXlZh6ah1UnE+i9/cTJog4r8SO
 eSA2yExliWVfciDCkhKfNkxmhbA9JK5tfgANq52MEqcOdTFOYJSfheS1WUjWQdhWEp0fmlhn
 AY1lFpCWWP6PA8LUlFi/S38BI+sqRsnUguLc9NRi0wLDvNRy5OjexAhO2FqeOxjvPvigd4iR
 iYPxEKMEB7OSCK9K0dcEId6UxMqq1KL8+KLSnNTiQ4ymwKiayCwlmpwPzBl5JfGGpkZmZgaW
 BqbGFmaGSuK87PFATQLpiSWp2ampBalFMH1MHJxSDUy13xmKrzDI39p262hQHqfigge7FHlD
 bNSZO28kS/Y9zWrcub/7kKW3v03HmQ5PndadrFYN6pkyAklz18ZzLmGZWMpe6/bj9hqFEt79
 HFP9MngPu6lkzu+NFA+XW79KvHjP8rS+pzJf7GafZJugf8c2keHfpOWdv43OO216anWn/X5w
 77ZPobcuzVu2Or+tdrOF4AF/ESGXWJvCI75id/mexOj2c9V2zplz3lvwqdXrwp1b3U+Lh/7c
 snUd45dl0jPWxz39nrnMX63OKue8+o6K6P2B/9PyFSJuTcm5eH3Woi9hIU/Upv2eFiujqlzH
 sXDO7dD75/9umB1hYcURvGX/K3sH+Wwesalt+8wEg5VYijMSDbWYi4oTAa2zYEphBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnK7S7K8JBptLLN5+fcBmcWX/eUaL
 /Qe/sVo8vvOZ3WLpfH2Lk417WC0mHbrGaLHkYqrF/GVP2S3m3VK2uP7zEbvFlSmLmC1mvWtn
 szjeu4PF4vWk/6wWN5ufsjkIePw4187mcW7HeXaPTas62Tw2L6n3eHJtM5PH+31X2Tz6tqxi
 DGCP4rJJSc3JLEst0rdL4Mr49201Y8EDgYoFLVOYGhg/cHcxcnJICJhIbG24xNrFyMUhJLCD
 UaJp2QxWiISkxPydM5ghbGGJlf+es0MUPWGUeHzwMFgRi4CqxNpv2xhBbDYBLYlZh/+DNYgI
 KEvcnT8TbCqzwG0mifbXN4CKODiEBVwlLv7MBqnhFdCV2N17gQ1i6E5GiTWfzzFCJAQlTs58
 wgJiMwuYSczb/JAZpJdZQFpi+T8OkDCngJPE/mk9TCC2KNCuA9uOM01gFJyFpHsWku5ZCN0L
 GJlXMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEx5qW1g7GPas+6B1iZOJgPMQowcGs
 JMKrUvQ1QYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQam
 5cte+bBz1i9+wv9B44a4cr151sxIRyvdORWZGVkZfVOMRS1ZIkxfmJ6zeFf+6s6Zqo7ff82j
 5h0rDl+X+r5MYQrzehWjGXs1f3ofYdNvuu+heYP32j3jc/lpHgkvDvGfPCi999oyiTn3JNT/
 pMV1z6+cftitVTEl8Kbn63DH7okLA3L1lybv+Bz5yvPV0WAvMTe3WkOBx643Pt6ZZy8aNenJ
 pO/TjENrOZmMopc7RS3ffPQk5ybziBmxnGdCJ/xJfvP56Yt/Psu8+O4t0O+1PH03UW/V/65n
 b6oipWa42VeV7D6563X5g3nq219MX92987DAw0cV8zgquxSnffxv9NzKdVu3m4XTfN53Bkvy
 lViKMxINtZiLihMBMoFkxiQDAAA=
X-CMS-MailID: 20210719153248epcas5p129bcb1396231522b157d4399ff3ed7f0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----jwvcjYHrFM3c_jtOMPe-K-pT79fi971tFzH_ulp86vm5ORTx=_a6d46_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210709145458epcas5p35826843853e7a8986098c4ff8fba857a
References: <CGME20210709145458epcas5p35826843853e7a8986098c4ff8fba857a@epcas5p3.samsung.com>
 <20210709145352.GA14300@test-zns>
 <20210709160430.GB291156@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_083527_460612_E42A0F66 
X-CRM114-Status: GOOD (  15.67  )
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

------jwvcjYHrFM3c_jtOMPe-K-pT79fi971tFzH_ulp86vm5ORTx=_a6d46_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Jul 09, 2021 at 09:04:30AM -0700, Keith Busch wrote:
>> +int hal_init()
>> +{
>> +    int retval = -1;
>> +    switch (GetSidebandInterface()) {
>> +    case qemu_nvme_mi:
>> +        retval = qemu_mi_init();
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +    return retval;
>> +}
>> +
>> +int hal_open()
>> +{
>> +    int retval = -1;
>> +    switch (GetSidebandInterface()) {
>> +    case qemu_nvme_mi:
>> +        retval = qemu_mi_open();
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +    return retval;
>> +}
>> +
>> +int hal_close()
>> +{
>> +    int retval = -1;
>> +    switch (GetSidebandInterface()) {
>> +    case qemu_nvme_mi:
>> +        retval = qemu_mi_close();
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +    return retval;
>> +}
>> +
>> +int hal_i2c_write(uint8_t *data_out, uint16_t num_bytes)
>> +{
>> +    int retval = -1;
>> +    switch (GetSidebandInterface()) {
>> +    case qemu_nvme_mi:
>> +        retval = qemu_mi_write(data_out, num_bytes);
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +    return retval;
>> +}
>> +
>> +int hal_i2c_read(uint8_t *data_in, uint16_t num_bytes)
>> +{
>> +    uint32_t retval = -1;
>> +    switch (GetSidebandInterface()) {
>> +    case qemu_nvme_mi:
>> +        retval = qemu_mi_read(data_in, num_bytes);
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +    return retval;
>> +}
>
>I'm really not a fan of having non-standard interfaces. If you were
>going to do that, though, you should create a struct of function
>pointers so that you don't need these repetitive "switch (...)"
>statements.
>
>But if we're going to have OOB MI support in toolign, they should all
>use the same standard defined interface.
>

Thanks for your comments.
We are planning to incorporate smbus/i2c interface in nvme-cli & qemu
and the patch will be shared in a few days.
While sharing the above patch, we will take care of the hardware
interface layer based on function pointer implementation as well.


------jwvcjYHrFM3c_jtOMPe-K-pT79fi971tFzH_ulp86vm5ORTx=_a6d46_
Content-Type: text/plain; charset="utf-8"


------jwvcjYHrFM3c_jtOMPe-K-pT79fi971tFzH_ulp86vm5ORTx=_a6d46_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

------jwvcjYHrFM3c_jtOMPe-K-pT79fi971tFzH_ulp86vm5ORTx=_a6d46_--


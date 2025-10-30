Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58294CCF9F0
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 06:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xLm/3rx+Br/Kb1FnJf05yBjWy1Z2qnInpjbtNJmpB/8=; b=mfxhQ2wLGvToHvVNbFy3AwStO7
	u/W/J8KQerqrKv385gF/BSxLN4Iw7ZrdaK0AFpH99Oe2fDNJHhhZ82TdcocO5ZjFyLSwsaNVfQa3c
	cL735ZO167m3Pxck+60NM+7No9s0XnELQM6IMTYBMdWNSaq4WTNQzssVQLuywFeRjBaMvInPyI63Y
	wYmBvQ9t848bHAAirCBfSV8b6fzzfjgxSZE30XSRGOkBXZjkp19qN2F13XE8EWiaJUmTaSzwqfHd1
	fJVEppf+8vITHS3L8RI3GO0qmPVDD9KF9oJtNO7sUAZok/yfrQaEbSoYi+79YTAsHNXmrpETc358o
	815UeI7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEMbf-00000003bEi-2D0Q;
	Thu, 30 Oct 2025 06:57:59 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEMbc-00000003bEI-3KBs
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 06:57:58 +0000
Received: from localhost (<unknown> [192.168.3.39])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id b4b44c43 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Oct 2025 07:57:54 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 07:57:54 +0100
Message-Id: <DDVGMKICWGM3.31KBSXQRF9E2S@bsdbackstore.eu>
Cc: "bgurney@redhat.com" <bgurney@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "Bart Van Assche"
 <bvanassche@acm.org>
Subject: Re: [PATCH] nvme-pci: expose active quirks in sysfs
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>, "Chaitanya Kulkarni"
 <chaitanyak@nvidia.com>, "Maurizio Lombardi" <mlombard@redhat.com>
X-Mailer: aerc
References: <20251028142916.700438-1-mlombard@redhat.com>
 <2bfd5388-0bde-4f86-9edf-fb74dd0d4c79@acm.org>
 <DDU46S76MOXJ.XX5QODFDZTZN@bsdbackstore.eu>
 <08f479ed-9817-4806-bf68-c929c8a844a6@nvidia.com>
 <DDUND9A6HFVR.14U2BRGS72CEP@bsdbackstore.eu>
 <5f38e8ae-41c3-46ef-ac3d-b6e1c106379f@nvidia.com>
 <DDVFSEFQUAUU.25A7L3KG2PBT1@bsdbackstore.eu>
 <f0bf5480-c66c-45a5-ae85-5bc0ff1bc172@nvidia.com>
 <DDVGKDJIDXG1.1KGMHIAQH3GVS@bsdbackstore.eu>
In-Reply-To: <DDVGKDJIDXG1.1KGMHIAQH3GVS@bsdbackstore.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_235757_184425_A8D3E54C 
X-CRM114-Status: GOOD (  12.30  )
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

On Thu Oct 30, 2025 at 7:55 AM CET, Maurizio Lombardi wrote:
> On Thu Oct 30, 2025 at 7:46 AM CET, Chaitanya Kulkarni wrote:
>> On 10/29/25 23:18, Maurizio Lombardi wrote:
>>
>> how about something like this totally untested ?
>>
>> drivers/nvme/host/pci.c | 64 +++++++++++++++++++++++++++++++++++++++++
>>  =C2=A01 file changed, 64 insertions(+)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index c916176bd9f0..ea9904e2dbd9 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -2497,6 +2497,69 @@ static ssize_t cmbsz_show(struct device *dev,=20
>> struct device_attribute *attr,
>>  =C2=A0}
>>  =C2=A0static DEVICE_ATTR_RO(cmbsz);
>>
>> +static const struct {
>> +=C2=A0 =C2=A0 unsigned long quirk;
>> +=C2=A0 =C2=A0 const char *name;
>> +} nvme_quirk_info[] =3D {
>> +=C2=A0 =C2=A0 { NVME_QUIRK_STRIPE_SIZE,=C2=A0 =C2=A0 =C2=A0 =C2=A0 "STR=
IPE_SIZE" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_IDENTIFY_CNS,=C2=A0 =C2=A0 =C2=A0 =C2=A0 "ID=
ENTIFY_CNS" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_DEALLOCATE_ZEROES,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 "DEALLOCATE_ZEROES" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_DELAY_BEFORE_CHK_RDY, "DELAY_BEFORE_CHK_RDY"=
 },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_NO_APST,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "NO_APST" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_NO_DEEPEST_PS,=C2=A0 =C2=A0 =C2=A0 =C2=A0 "N=
O_DEEPEST_PS" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_QDEPTH_ONE,=C2=A0 =C2=A0 =C2=A0 =C2=A0 "QDEP=
TH_ONE" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_MEDIUM_PRIO_SQ,=C2=A0 =C2=A0 =C2=A0 =C2=A0 "=
MEDIUM_PRIO_SQ" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_IGNORE_DEV_SUBNQN,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 "IGNORE_DEV_SUBNQN" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_DISABLE_WRITE_ZEROES, "DISABLE_WRITE_ZEROES"=
 },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_SIMPLE_SUSPEND,=C2=A0 =C2=A0 =C2=A0 =C2=A0 "=
SIMPLE_SUSPEND" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_SINGLE_VECTOR,=C2=A0 =C2=A0 =C2=A0 =C2=A0 "S=
INGLE_VECTOR" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_128_BYTES_SQES,=C2=A0 =C2=A0 =C2=A0 =C2=A0 "=
128_BYTES_SQES" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_SHARED_TAGS,=C2=A0 =C2=A0 =C2=A0 =C2=A0 "SHA=
RED_TAGS" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_NO_TEMP_THRESH_CHANGE, "NO_TEMP_THRESH_CHANG=
E" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_NO_NS_DESC_LIST,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
"NO_NS_DESC_LIST" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_DMA_ADDRESS_BITS_48,=C2=A0 =C2=A0 "DMA_ADDRE=
SS_BITS_48" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_SKIP_CID_GEN,=C2=A0 =C2=A0 =C2=A0 =C2=A0 "SK=
IP_CID_GEN" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_BOGUS_NID,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "BOGUS_NID" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_NO_SECONDARY_TEMP_THRESH, "NO_SECONDARY_TEMP=
_THRESH" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND, "FORCE_NO_SIMPLE_SU=
SPEND" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_BROKEN_MSI,=C2=A0 =C2=A0 =C2=A0 =C2=A0 "BROK=
EN_MSI" },
>> +=C2=A0 =C2=A0 { NVME_QUIRK_DMAPOOL_ALIGN_512,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 "DMAPOOL_ALIGN_512" },
>> +};
>
> Hmm, NVME_QUIRK_DMAPOOL_ALIGN_512 is "1 << 22", wouldn't this create=20
> an enormous array?

Sorry, my mistake, this is completely ok.

So yes, it would be fine, the only drawback is that with the switch()
the compiler would raise a warning if someone adds a new quirk and
forgets to add its name to the nvme_quirk_name() function.

>
> Maurizio
>
>> +
>> +static int nvme_get_quirks_string(unsigned long quirks, char *buf,=20
>> size_t buf_len)
>> +{
>> +=C2=A0 =C2=A0 size_t len =3D 0;
>> +=C2=A0 =C2=A0 int i;
>> +
>> +=C2=A0 =C2=A0 if (!quirks) {
>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D scnprintf(buf, buf_len, "No quirks =
enabled\n");
>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;
>> +=C2=A0 =C2=A0 }
>> +
>> +=C2=A0 =C2=A0 len +=3D scnprintf(buf + len, buf_len - len, "Active quir=
ks:\n");
>> +
>> +=C2=A0 =C2=A0 for (i =3D 0; i < ARRAY_SIZE(nvme_quirk_info); i++) {
>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (quirks & nvme_quirk_info[i].quirk)
>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D scnprintf(buf + len,=
 buf_len - len, " %s\n",
>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0nvme_quirk_info[i].name);
>> +=C2=A0 =C2=A0 }
>> +
>> +=C2=A0 =C2=A0 return len;
>> +}
>> +
>> +static ssize_t quirks_show(struct device *dev, struct device_attribute=
=20
>> *attr,
>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *buf)
>> +{
>> +=C2=A0 =C2=A0 struct nvme_dev *ndev =3D to_nvme_dev(dev_get_drvdata(dev=
));
>> +=C2=A0 =C2=A0 int len;
>> +
>> +=C2=A0 =C2=A0 len =3D sysfs_emit(buf, "0x%016lx\n\n", ndev->ctrl.quirks=
);
>> +=C2=A0 =C2=A0 len +=3D nvme_get_quirks_string(ndev->ctrl.quirks, buf + =
len,=20
>> PAGE_SIZE - len);
>> +
>> +=C2=A0 =C2=A0 return len;
>> +}
>> +static DEVICE_ATTR_RO(quirks);
>> +
>>  =C2=A0static ssize_t hmb_show(struct device *dev, struct device_attribu=
te *attr,
>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *buf)
>>  =C2=A0{
>> @@ -2557,6 +2620,7 @@ static struct attribute *nvme_pci_attrs[] =3D {
>>  =C2=A0 =C2=A0 =C2=A0&dev_attr_cmbloc.attr,
>>  =C2=A0 =C2=A0 =C2=A0&dev_attr_cmbsz.attr,
>>  =C2=A0 =C2=A0 =C2=A0&dev_attr_hmb.attr,
>> +=C2=A0 =C2=A0 &dev_attr_quirks.attr,
>>  =C2=A0 =C2=A0 =C2=A0NULL,
>>  =C2=A0};



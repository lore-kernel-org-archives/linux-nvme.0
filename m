Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD0ACCF9F6
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 06:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EAIRs6Q7FyL1jgzP/+Okv7XQLeNmiDHxa5HVmrGRLOc=; b=NBQ/+HvS3kd7K8r/AO+P1LanAg
	aB4bqc0Y+5sofvDtB9mITb2XkbabKxYgjEBoixPPcS1ZVzAZ9oI4gAJ+NLvJbecJpVDOdm+vHGS6G
	FJ2xf0YQMh5rHnZty88spRmK7v8rsUIkJydt0y/Ge9twbCvqrV0PKlm4vJ36oOgnxH0wx1E9kaqH+
	ACn5+lWQMnLMErHCebp8SkFwKhSxVD4j/R+fUnn3mgMUVlptNeB1ekHIGsSeZIXe3cMR6BNJoPyMm
	px1RTIOOe1PXWs8Mj8aTGvlHVZXA05PTTCCQBUYNRhS2HUT62zUKxM8CcqN6DDMmzKBWt+2JKyyfl
	PmiQAlEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEM62-00000003Yna-0i2f;
	Thu, 30 Oct 2025 06:25:18 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEM5z-00000003Yn7-1K7Y
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 06:25:17 +0000
Received: from localhost (<unknown> [192.168.3.39])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 78df4b9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Oct 2025 07:18:30 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 07:18:30 +0100
Message-Id: <DDVFSEFQUAUU.25A7L3KG2PBT1@bsdbackstore.eu>
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Chaitanya Kulkarni" <chaitanyak@nvidia.com>, "Bart Van Assche"
 <bvanassche@acm.org>, "Maurizio Lombardi" <mlombard@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>
Cc: "bgurney@redhat.com" <bgurney@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: expose active quirks in sysfs
X-Mailer: aerc
References: <20251028142916.700438-1-mlombard@redhat.com>
 <2bfd5388-0bde-4f86-9edf-fb74dd0d4c79@acm.org>
 <DDU46S76MOXJ.XX5QODFDZTZN@bsdbackstore.eu>
 <08f479ed-9817-4806-bf68-c929c8a844a6@nvidia.com>
 <DDUND9A6HFVR.14U2BRGS72CEP@bsdbackstore.eu>
 <5f38e8ae-41c3-46ef-ac3d-b6e1c106379f@nvidia.com>
In-Reply-To: <5f38e8ae-41c3-46ef-ac3d-b6e1c106379f@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_232515_723038_9590232F 
X-CRM114-Status: GOOD (  27.04  )
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

On Thu Oct 30, 2025 at 12:25 AM CET, Chaitanya Kulkarni wrote:
> On 10/29/25 01:02, Maurizio Lombardi wrote:
>> On Wed Oct 29, 2025 at 6:47 AM CET, Chaitanya Kulkarni wrote:
>>> On 10/28/25 10:00, Maurizio Lombardi wrote:
>>>> On Tue Oct 28, 2025 at 5:32 PM CET, Bart Van Assche wrote:
>>>>> On 10/28/25 7:29 AM, Maurizio Lombardi wrote:
>>>>>> Currently, there is no straightforward way for a user to inspect
>>>>>> the quirks value from userspace.
>>>>>> Add a new read-only sysfs attribute "quirks";
>>>>>> reading this file will display the hexadecimal
>>>>>> value of the ctrl->quirks bitmask for the given NVMe device.
>>>>> This patch changes the constants in enum nvme_quirks from
>>>>> kernel-internal constants into an ABI. I'm not sure that's what we
>>>>> want.
>>>> I understand your concern.
>>>> I could respin it to export the names of the active quirks
>>>> rather than the raw bitmask, if there is an interest in having
>>>> this feature.
>>>>
>>>> Maurizio
>>>>
>>> question here: do we need to care about some kind of security before we
>>> expose controller information that is internal to the driver ?
>>> CAP_SYS_ADMIN ? -ck
>> IMO I don't think it's an information that needs to be hidden.
>> After all, any user could run "lscpi -nn", get the vendor and device
>> id and cross-reference them with the pci table in the source code
>> to get the enabled quirks, this sysfs entry would just make it faster.
>>
>> Maurizio
>
> Yes it is definitely useful after only decoding :-
>
> linux-block (for-next) # cat /sys/class/nvme/nvme0/quirks
> 0x0000000000040000
>
> Active quirks:
>    BOGUS_NID
> linux-block (for-next) #

Ah you anticipated me, I was preparing a somewhat similar patch.

************************

Currently, there is no straightforward way for a user to inspect
which quirks are active for a given device from userspace.

Add a new "quirks" sysfs attribute to the nvme controller device.

Reading this file will display a human-readable list
of all active quirks, with each quirk name on a new line.
If no quirks are active, it will display "none".

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---

V2: Do not expose kernel-internal constants to userspace.
    Move the quirks attribute to the controller device, where it belongs.

 drivers/nvme/host/nvme.h  | 54 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/sysfs.c | 23 +++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 102fae6a231c..647f19dd57e9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -180,6 +180,60 @@ enum nvme_quirks {
 	NVME_QUIRK_DMAPOOL_ALIGN_512		=3D (1 << 22),
 };

+static inline char *nvme_quirk_name(enum nvme_quirks q)
+{
+	switch (q) {
+	case NVME_QUIRK_STRIPE_SIZE:
+		return "stripe_size";
+	case NVME_QUIRK_IDENTIFY_CNS:
+		return "identify_cns";
+	case NVME_QUIRK_DEALLOCATE_ZEROES:
+		return "deallocate_zeroes";
+	case NVME_QUIRK_DELAY_BEFORE_CHK_RDY:
+		return "delay_before_chk_rdy";
+	case NVME_QUIRK_NO_APST:
+		return "no_apst";
+	case NVME_QUIRK_NO_DEEPEST_PS:
+		return "no_deepest_ps";
+	case NVME_QUIRK_QDEPTH_ONE:
+		return "qdepth_one";
+	case NVME_QUIRK_MEDIUM_PRIO_SQ:
+		return "medium_prio_sq";
+	case NVME_QUIRK_IGNORE_DEV_SUBNQN:
+		return "ignore_dev_subnqn";
+	case NVME_QUIRK_DISABLE_WRITE_ZEROES:
+		return "disable_write_zeroes";
+	case NVME_QUIRK_SIMPLE_SUSPEND:
+		return "simple_suspend";
+	case NVME_QUIRK_SINGLE_VECTOR:
+		return "single_vector";
+	case NVME_QUIRK_128_BYTES_SQES:
+		return "128_bytes_sqes";
+	case NVME_QUIRK_SHARED_TAGS:
+		return "shared_tags";
+	case NVME_QUIRK_NO_TEMP_THRESH_CHANGE:
+		return "no_temp_thresh_change";
+	case NVME_QUIRK_NO_NS_DESC_LIST:
+		return "no_ns_desc_list";
+	case NVME_QUIRK_DMA_ADDRESS_BITS_48:
+		return "dma_address_bits_48";
+	case NVME_QUIRK_SKIP_CID_GEN:
+		return "skip_cid_gen";
+	case NVME_QUIRK_BOGUS_NID:
+		return "bogus_nid";
+	case NVME_QUIRK_NO_SECONDARY_TEMP_THRESH:
+		return "no_secondary_temp_thresh";
+	case NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND:
+		return "force_no_simple_suspend";
+	case NVME_QUIRK_BROKEN_MSI:
+		return "broken_msi";
+	case NVME_QUIRK_DMAPOOL_ALIGN_512:
+		return "dmapool_align_512";
+	}
+
+	return "unknown";
+}
+
 /*
  * Common request structure for NVMe passthrough.  All drivers must have
  * this structure as the first member of their request-private data.
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..16c6fea4b2db 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -601,6 +601,28 @@ static ssize_t dctype_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(dctype);

+static ssize_t quirks_show(struct device *dev, struct device_attribute *at=
tr,
+                char *buf)
+{
+	int count =3D 0, i;
+	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
+	unsigned long quirks =3D ctrl->quirks;
+
+	if (!quirks)
+		return sysfs_emit(buf, "none\n");
+
+	for (i =3D 0; quirks; ++i) {
+		if (quirks & 1) {
+			count +=3D sysfs_emit_at(buf, count, "%s\n",
+					nvme_quirk_name(BIT(i)));
+		}
+		quirks >>=3D 1;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_RO(quirks);
+
 #ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -742,6 +764,7 @@ static struct attribute *nvme_dev_attrs[] =3D {
 	&dev_attr_kato.attr,
 	&dev_attr_cntrltype.attr,
 	&dev_attr_dctype.attr,
+	&dev_attr_quirks.attr,
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
--
2.47.3

>
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c916176bd9f0..1b9ad818b12d 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2497,6 +2497,80 @@ static ssize_t cmbsz_show(struct device *dev, stru=
ct device_attribute *attr,
>   }
>   static DEVICE_ATTR_RO(cmbsz);
>  =20
> +static int nvme_get_quirks_string(unsigned long quirks, char *buf, size_=
t buf_len)
> +{
> +	size_t len =3D 0;
> +
> +	if (!quirks) {
> +		len =3D scnprintf(buf, buf_len, "No quirks enabled\n");
> +		return len;
> +	}
> +
> +	len +=3D scnprintf(buf + len, buf_len - len, "Active quirks:\n");
> +
> +	if (quirks & NVME_QUIRK_STRIPE_SIZE)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  STRIPE_SIZE\n");
> +	if (quirks & NVME_QUIRK_IDENTIFY_CNS)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  IDENTIFY_CNS\n");
> +	if (quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  DEALLOCATE_ZEROES\n");
> +	if (quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  DELAY_BEFORE_CHK_RDY\n=
");
> +	if (quirks & NVME_QUIRK_NO_APST)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  NO_APST\n");
> +	if (quirks & NVME_QUIRK_NO_DEEPEST_PS)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  NO_DEEPEST_PS\n");
> +	if (quirks & NVME_QUIRK_QDEPTH_ONE)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  QDEPTH_ONE\n");
> +	if (quirks & NVME_QUIRK_MEDIUM_PRIO_SQ)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  MEDIUM_PRIO_SQ\n");
> +	if (quirks & NVME_QUIRK_IGNORE_DEV_SUBNQN)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  IGNORE_DEV_SUBNQN\n");
> +	if (quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  DISABLE_WRITE_ZEROES\n=
");
> +	if (quirks & NVME_QUIRK_SIMPLE_SUSPEND)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  SIMPLE_SUSPEND\n");
> +	if (quirks & NVME_QUIRK_SINGLE_VECTOR)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  SINGLE_VECTOR\n");
> +	if (quirks & NVME_QUIRK_128_BYTES_SQES)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  128_BYTES_SQES\n");
> +	if (quirks & NVME_QUIRK_SHARED_TAGS)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  SHARED_TAGS\n");
> +	if (quirks & NVME_QUIRK_NO_TEMP_THRESH_CHANGE)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  NO_TEMP_THRESH_CHANGE\=
n");
> +	if (quirks & NVME_QUIRK_NO_NS_DESC_LIST)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  NO_NS_DESC_LIST\n");
> +	if (quirks & NVME_QUIRK_DMA_ADDRESS_BITS_48)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  DMA_ADDRESS_BITS_48\n"=
);
> +	if (quirks & NVME_QUIRK_SKIP_CID_GEN)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  SKIP_CID_GEN\n");
> +	if (quirks & NVME_QUIRK_BOGUS_NID)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  BOGUS_NID\n");
> +	if (quirks & NVME_QUIRK_NO_SECONDARY_TEMP_THRESH)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  NO_SECONDARY_TEMP_THRE=
SH\n");
> +	if (quirks & NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  FORCE_NO_SIMPLE_SUSPEN=
D\n");
> +	if (quirks & NVME_QUIRK_BROKEN_MSI)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  BROKEN_MSI\n");
> +	if (quirks & NVME_QUIRK_DMAPOOL_ALIGN_512)
> +		len +=3D scnprintf(buf + len, buf_len - len, "  DMAPOOL_ALIGN_512\n");
> +
> +	return len;
> +}
> +
> +static ssize_t quirks_show(struct device *dev, struct device_attribute *=
attr,
> +			   char *buf)
> +{
> +	struct nvme_dev *ndev =3D to_nvme_dev(dev_get_drvdata(dev));
> +	int len;
> +
> +	len =3D sysfs_emit(buf, "0x%016lx\n\n", ndev->ctrl.quirks);
> +	len +=3D nvme_get_quirks_string(ndev->ctrl.quirks, buf + len, PAGE_SIZE=
 - len);
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RO(quirks);
> +
>   static ssize_t hmb_show(struct device *dev, struct device_attribute *at=
tr,
>   			char *buf)
>   {
> @@ -2557,6 +2631,7 @@ static struct attribute *nvme_pci_attrs[] =3D {
>   	&dev_attr_cmbloc.attr,
>   	&dev_attr_cmbsz.attr,
>   	&dev_attr_hmb.attr,
> +	&dev_attr_quirks.attr,
>   	NULL,
>   };
>  =20



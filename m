Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2737606A320
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dLpr22Kn;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EmAXGLIl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:
	Cc:To:Subject:MIME-Version:Date:Message-ID:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hdub2JabO8W4/iNKxXdGmLEDPpEpU2rQVqO8NEgZJwA=; b=dLpr22KnS81gXb3prJa/ALDLa6
	iWB1gqDNP1HyeQUiBf2/xRT2NUPAKQrhJRc2Emb8qGTlyzKEbRYW7W9ALw7V1KrrnhMVw3Nz6ZTkY
	h/uw5ISFtMRKJcSyIgeFCg3DzSoJHRt4k3Udgedc6BT00YStcVG8pO5Ra2JNt+yA4RgpkcJ2UdRxO
	9yuIVHC3exoo6XTFZTq1HnHlXvPaH9zwcXOV0EORk57gALImzAona3wuf2SFWNsxC5IgAIAkTcgtr
	trg4J65WLBjlW2axnIOzyap9EPYw+EONvR4kBjBydNESe540tthyN1k4suBLWBNxS4GE+lnG5k72q
	hBtlIn8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR2iK-00000005u0V-2jwW;
	Wed, 11 Nov 2026 07:25:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR2iH-00000005tzS-45bb
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 07:25:47 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5iKQm3260843;
	Wed, 11 Nov 2026 07:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hdub2JabO8W4/iNKxXdGmLEDPpEpU2
	rQVqO8NEgZJwA=; b=EmAXGLIlvggiutiVC+PsFYneStkdOu1czIRgk3vBd4zWb9
	u5mz0D7n+aqGOOaDV1OirWb1qfU19dM6H2BI4wxOG/KoBw0vBJE/+/MLjzwY0ITg
	0Ai5ToishSlOOaUU217WdzS6gS3D86ZIGzDruFsGGOFNkpTNLVJ3XLXfGiz7MbnU
	vPNRI0u+Kkbrd6eaJcpCvs2hnVoSFIHKIqDlK3UEig221AXbDxBRXhNdAJ4ZtVvr
	TpMrOVz6vNjLoF0s8wJhxQ2ljSg7G3Nmqb94VbMk1UhFxl7Ms47vVPPmN4dYkGcY
	6B2NIBgpUltQ82afSf8DY03EDMb4dIwhQXEwtemA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg8cua-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 07:25:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5JuDq2913717;
	Wed, 11 Nov 2026 07:25:28 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv4nsu66j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 07:25:28 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AB7PRk815794818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 07:25:27 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABB8658059;
	Wed, 11 Nov 2026 07:25:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A878258057;
	Wed, 11 Nov 2026 07:25:24 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 07:25:24 +0000 (GMT)
Content-Type: multipart/mixed; boundary="------------qLokLvW35d7oFwP8kdQmI2z9"
Message-ID: <e31029f5-c022-4fc9-be94-d1faadfb327e@linux.ibm.com>
Date: Wed, 11 Nov 2026 12:55:23 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/23] nvmet: add context annotation for nvmet_ns::bdev
To: Bart Van Assche <bvanassche@acm.org>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-26-nilay@linux.ibm.com>
 <8beba915-07a5-4eae-b8a4-3ec7330c90f7@acm.org>
 <e9f42390-9115-40b2-b0a5-df17c53ce38b@linux.ibm.com>
 <6708de12-ed0d-4101-9328-d08864e677a5@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <6708de12-ed0d-4101-9328-d08864e677a5@acm.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af41869 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=r77TgQKjGQsHNAKrUKIA:9 a=JtNYY7H3HdtMDr7ioUwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=BlEzejNmBzUOBiadcDEA:9
 a=De_Ol2h6w80A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfX/YFaaFqVMHJc
 leVrcQzk/hkYXrs9VhyY22LULJU51Ln34gIz2NusA7HkSjPJckGYZOVZ0Pr/HbDcFNpa7u2oXru
 92JVNWpMUe9P4336Zv6pAIYYcFytKPAvLXsC/ed2fLKCzQwe9/5lYWNrpejjGG5YOZ2gD0J3+Jj
 A087LVe6TWa7b3JEdVvFxNhiBM9p++XmT8ic7Rdq3QZPrOwAA7XvIIe5kcIiCrsLfXRn05tVYcO
 kiOx9Kz5eEohB7p4x2Xda6HK22EXpi5968GohY9QCeTVsnAeUr2gne0MOgG8oDba0PPWRfA9VuY
 Bk5+gMnCdMm5vM0KfqKDS+wrO7xpcn6AeuJbr1bU7zDiG16YHm5VPfp0I6ViwkxmPaL/GRkxHkR
 sZ1IqJwVObFsiOIg1Tcc7D5RrIcMsEMsJouiFkSL40eYme/2aceY/kgfvoDWkSITx9+OVuuzNT5
 isAwcEqylbSVzieiHxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfX1oZNf/821cCV
 KKdJD5G0OBZZUIqRLUGxMpSrRxHxOo+p2dwAizHjAusVUR0yqxXfwNBL4jhbbWbntO9XPXWcjUx
 Yhne2l8feJWZdGfoAZDNSbRJ6pJ1hnk=
X-Proofpoint-GUID: agPREq4oMrmZ01VGNH1ffg_wnBWth-Ne
X-Proofpoint-ORIG-GUID: IVYUy_PjxD30T4wSaSv8u-j6eW2-8huT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110028
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_232546_163884_E5524085 
X-CRM114-Status: GOOD (  28.79  )
X-Spam-Score: -2.6 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------qLokLvW35d7oFwP8kdQmI2z9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/26 10:59 PM, Bart Van Assche wrote:
> On 11/9/26 10:38 PM, Nilay Shroff wrote:
>> I agree that passing the lock owner as a function argument is preferable whenever
>> possible. For this particular case, I tried passing subsys down the call chain to
>> nvmet_ns_dev() and annotating the function with __must_hold(&subsys-  >lock). However,
>> Clang still reports a locking violation when accessing ns->bdev:
> 
> Please take a look at the attached patches and consider to add these to
> the start of this series. These patches are needed to implement what I
> suggested in my previous email in this email thread.
> 
I reviewed the patches you attached and tried implementing your suggestion by passing
the struct nvmet_subsys pointer down the call chain to nvmet_ns_dev(), which accesses
ns->bdev protected by subsys->lock.

The relevant code looks like this:

struct nvmet_subsys {
     ...
     struct mutex lock;
     ...
}

struct nvmet_ns {
     ...
     struct block_device	*bdev __guarded_by(&subsys->lock);
     ...
     struct nvmet_subsys	*subsys;
     ...
}

static inline struct device *nvmet_ns_dev(struct nvmet_subsys *subsys,
		struct nvmet_ns *ns)
	__must_hold(&subsys->lock)
{
	return ns->bdev ? disk_to_dev(ns->bdev->bd_disk) : NULL;
}

Attached the complete patch for your reference. Even after making
this change, clang still complains about locking violation:

drivers/nvme/target/nvmet.h:255:13: error: reading variable 'bdev' requires holding mutex 'ns->subsys->lock' [-Werror,-Wthread-safety-precise]
   255 |         return ns->bdev ? disk_to_dev(ns->bdev->bd_disk) : NULL;
       |                    ^
drivers/nvme/target/nvmet.h:255:13: note: found near match 'subsys->lock'

 From this error, it appears that the Clang context analyzer expects accesses
to ns->bdev to be protected specifically by ns->subsys->lock. It recognizes
subsys->lock as a near match but cannot establish that both expressions refer
to the same mutex.

Therefore, passing the subsys pointer down to nvmet_ns_dev() and annotating the
function with __must_hold(&subsys->lock) does not resolve the warning in this case.

I also looked at the approach in your proposed patches for the NVMe host driver.
There, passing the struct nvme_subsystem pointer down the call chain works because
the list being protected, nsheads, is itself a member of struct nvme_subsystem:


struct nvme_subsystem {
     ....
     struct mutex lock;
     struct list_head nsheads __guarded_by(&lock);
     ....
}

In this case, the analyzer can associate accesses to subsys->nsheads directly with
subsys->lock, allowing __must_hold(&subsys->lock) to express the locking requirement
correctly.

The situation is different for nvmet_ns::bdev, where the lock protecting the field
belongs to the namespace's subsystem which is a separate struct nvmet_subsys. It seems
the analyzer cannot establish the equivalence between subsys->lock and ns->subsys->lock,
even when both pointers refer to the same subsystem.

Regarding your patches, I'm happy to include them in my series. However, my current
series focuses on adding context annotations to the NVMe target driver, whereas your
proposed patches address the NVMe host driver. So I'd suggest posting your changes as
a separate series so they can be reviewed independently.

Thanks,
--Nilay

--------------qLokLvW35d7oFwP8kdQmI2z9
Content-Type: text/x-patch; charset=UTF-8; name="nvmet-ns-bdev.diff"
Content-Disposition: attachment; filename="nvmet-ns-bdev.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jIGIvZHJpdmVycy9udm1l
L3RhcmdldC9jb3JlLmMKaW5kZXggYzk4MzcyNjM4OThhLi45ODI3NDllZmE2ZTEgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jCisrKyBiL2RyaXZlcnMvbnZtZS90
YXJnZXQvY29yZS5jCkBAIC00OTAsOCArNDkwLDkgQEAgc3RhdGljIHZvaWQgbnZtZXRfbnNf
ZGV2X2Rpc2FibGUoc3RydWN0IG52bWV0X25zICpucykKIAludm1ldF9maWxlX25zX2Rpc2Fi
bGUobnMpOwogfQogCi1zdGF0aWMgaW50IG52bWV0X3AycG1lbV9uc19lbmFibGUoc3RydWN0
IG52bWV0X25zICpucykKLQlfX211c3RfaG9sZCgmbnMtPnN1YnN5cy0+bG9jaykKK3N0YXRp
YyBpbnQgbnZtZXRfcDJwbWVtX25zX2VuYWJsZShzdHJ1Y3QgbnZtZXRfc3Vic3lzICpzdWJz
eXMsCisJCXN0cnVjdCBudm1ldF9ucyAqbnMpCisJX19tdXN0X2hvbGQoJnN1YnN5cy0+bG9j
aykKIHsKIAlpbnQgcmV0OwogCXN0cnVjdCBwY2lfZGV2ICpwMnBfZGV2OwpAQCAtNTExLDcg
KzUxMiw4IEBAIHN0YXRpYyBpbnQgbnZtZXRfcDJwbWVtX25zX2VuYWJsZShzdHJ1Y3QgbnZt
ZXRfbnMgKm5zKQogCX0KIAogCWlmIChucy0+cDJwX2RldikgewotCQlyZXQgPSBwY2lfcDJw
ZG1hX2Rpc3RhbmNlKG5zLT5wMnBfZGV2LCBudm1ldF9uc19kZXYobnMpLCB0cnVlKTsKKwkJ
cmV0ID0gcGNpX3AycGRtYV9kaXN0YW5jZShucy0+cDJwX2RldiwgbnZtZXRfbnNfZGV2KHN1
YnN5cywgbnMpLAorCQkJCXRydWUpOwogCQlpZiAocmV0IDwgMCkKIAkJCXJldHVybiAtRUlO
VkFMOwogCX0gZWxzZSB7CkBAIC01MjIsNyArNTI0LDcgQEAgc3RhdGljIGludCBudm1ldF9w
MnBtZW1fbnNfZW5hYmxlKHN0cnVjdCBudm1ldF9ucyAqbnMpCiAJCSAqIHNldHVwIHRoZSBj
b250cm9sbGVyIHdoZW4gdGhlIHBvcnQncyBkZXZpY2UgaXMgYXZhaWxhYmxlLgogCQkgKi8K
IAotCQlwMnBfZGV2ID0gcGNpX3AycG1lbV9maW5kKG52bWV0X25zX2RldihucykpOworCQlw
MnBfZGV2ID0gcGNpX3AycG1lbV9maW5kKG52bWV0X25zX2RldihzdWJzeXMsIG5zKSk7CiAJ
CWlmICghcDJwX2RldikgewogCQkJcHJfZXJyKCJubyBwZWVyLXRvLXBlZXIgbWVtb3J5IGlz
IGF2YWlsYWJsZSBmb3IgJXNcbiIsCiAJCQkgICAgICAgbnMtPmRldmljZV9wYXRoKTsKQEAg
LTUzNSwyMSArNTM3LDE2IEBAIHN0YXRpYyBpbnQgbnZtZXRfcDJwbWVtX25zX2VuYWJsZShz
dHJ1Y3QgbnZtZXRfbnMgKm5zKQogCXJldHVybiAwOwogfQogCi1zdGF0aWMgdm9pZCBudm1l
dF9wMnBtZW1fbnNfYWRkX3AycChzdHJ1Y3QgbnZtZXRfY3RybCAqY3RybCwKK3N0YXRpYyB2
b2lkIG52bWV0X3AycG1lbV9uc19hZGRfcDJwKHN0cnVjdCBudm1ldF9zdWJzeXMgKnN1YnN5
cywKKwkJCQkgICAgc3RydWN0IG52bWV0X2N0cmwgKmN0cmwsCiAJCQkJICAgIHN0cnVjdCBu
dm1ldF9ucyAqbnMpCi0JX19tdXN0X2hvbGQoJmN0cmwtPnN1YnN5cy0+bG9jaykKKwlfX211
c3RfaG9sZCgmc3Vic3lzLT5sb2NrKQogewogCXN0cnVjdCBkZXZpY2UgKmNsaWVudHNbMl07
CiAJc3RydWN0IHBjaV9kZXYgKnAycF9kZXY7CiAJaW50IHJldDsKIAotCWxvY2tkZXBfYXNz
ZXJ0X2hlbGQoJmN0cmwtPnN1YnN5cy0+bG9jayk7Ci0JLyoKLQkgKiBCb3RoIGN0cmwtPnN1
YnN5cy0+bG9jayBhbmQgbnMtPnN1YnN5cy0+bG9jayByZWZlcnMgdG8gdGhlIHNhbWUgbG9j
ay4KLQkgKiBIb3dldmVyIHRoZXJlJ3Mgbm8gd2F5IGZvciB1cyB0byBhbm5vdGF0ZSBzdWNo
IGxvY2tpbmcgc2VtYW50aWNzCi0JICogdXNpbmcgY2xhbmcgY29udGV4dCBhbm5vdGF0aW9u
LiBTbyBleHBsaWNpdGx5IGFzc2VydCB0aGUgY2FwYWJpbGl0eS4KLQkgKi8KLQlfX2Fzc3Vt
ZV9jdHhfbG9jaygmbnMtPnN1YnN5cy0+bG9jayk7CisJbG9ja2RlcF9hc3NlcnRfaGVsZCgm
c3Vic3lzLT5sb2NrKTsKIAogCWlmICghY3RybC0+cDJwX2NsaWVudCB8fCAhbnMtPnVzZV9w
MnBtZW0pCiAJCXJldHVybjsKQEAgLTU2Miw3ICs1NTksNyBAQCBzdGF0aWMgdm9pZCBudm1l
dF9wMnBtZW1fbnNfYWRkX3AycChzdHJ1Y3QgbnZtZXRfY3RybCAqY3RybCwKIAkJcDJwX2Rl
diA9IHBjaV9kZXZfZ2V0KG5zLT5wMnBfZGV2KTsKIAl9IGVsc2UgewogCQljbGllbnRzWzBd
ID0gY3RybC0+cDJwX2NsaWVudDsKLQkJY2xpZW50c1sxXSA9IG52bWV0X25zX2Rldihucyk7
CisJCWNsaWVudHNbMV0gPSBudm1ldF9uc19kZXYoc3Vic3lzLCBucyk7CiAKIAkJcDJwX2Rl
diA9IHBjaV9wMnBtZW1fZmluZF9tYW55KGNsaWVudHMsIEFSUkFZX1NJWkUoY2xpZW50cykp
OwogCQlpZiAoIXAycF9kZXYpIHsKQEAgLTYyMCwyMCArNjE3LDEyIEBAIGludCBudm1ldF9u
c19lbmFibGUoc3RydWN0IG52bWV0X25zICpucykKIAlpZiAocmV0KQogCQlnb3RvIG91dF91
bmxvY2s7CiAKLQlyZXQgPSBudm1ldF9wMnBtZW1fbnNfZW5hYmxlKG5zKTsKKwlyZXQgPSBu
dm1ldF9wMnBtZW1fbnNfZW5hYmxlKHN1YnN5cywgbnMpOwogCWlmIChyZXQpCiAJCWdvdG8g
b3V0X2Rldl9kaXNhYmxlOwogCi0JbGlzdF9mb3JfZWFjaF9lbnRyeShjdHJsLCAmc3Vic3lz
LT5jdHJscywgc3Vic3lzX2VudHJ5KSB7Ci0JCS8qCi0JCSAqIEJvdGggc3Vic3lzLT5sb2Nr
IGFuZCBjdHJsLT5zdWJzeXMtPmxvY2sgcmVmZXJzIHRvIHRoZSBzYW1lCi0JCSAqIGxvY2su
IEhvd2V2ZXIgdGhlcmUncyBubyB3YXkgZm9yIHVzIHRvIGFubm90YXRlIHN1Y2ggbG9ja2lu
ZwotCQkgKiBzZW1hbnRpY3MgdXNpbmcgY2xhbmcgY29udGV4dCBhbm5vdGF0aW9uLiBTbyBl
eHBsaWNpdGx5Ci0JCSAqIGFzc2VydCB0aGUgY2FwYWJpbGl0eS4KLQkJICovCi0JCV9fYXNz
dW1lX2N0eF9sb2NrKCZjdHJsLT5zdWJzeXMtPmxvY2spOwotCQludm1ldF9wMnBtZW1fbnNf
YWRkX3AycChjdHJsLCBucyk7Ci0JfQorCWxpc3RfZm9yX2VhY2hfZW50cnkoY3RybCwgJnN1
YnN5cy0+Y3RybHMsIHN1YnN5c19lbnRyeSkKKwkJbnZtZXRfcDJwbWVtX25zX2FkZF9wMnAo
c3Vic3lzLCBjdHJsLCBucyk7CiAKIAlpZiAobnMtPnByLmVuYWJsZSkgewogCQlyZXQgPSBu
dm1ldF9wcl9pbml0X25zKG5zKTsKQEAgLTE1OTEsMTQgKzE1ODAsMTUgQEAgYm9vbCBudm1l
dF9ob3N0X2FsbG93ZWQoc3RydWN0IG52bWV0X3N1YnN5cyAqc3Vic3lzLCBjb25zdCBjaGFy
ICpob3N0bnFuKQogCXJldHVybiBmYWxzZTsKIH0KIAotc3RhdGljIHZvaWQgbnZtZXRfc2V0
dXBfcDJwX25zX21hcChzdHJ1Y3QgbnZtZXRfY3RybCAqY3RybCwKLQkJc3RydWN0IGRldmlj
ZSAqcDJwX2NsaWVudCkKLQlfX211c3RfaG9sZCgmY3RybC0+c3Vic3lzLT5sb2NrKQorc3Rh
dGljIHZvaWQgbnZtZXRfc2V0dXBfcDJwX25zX21hcChzdHJ1Y3QgbnZtZXRfc3Vic3lzICpz
dWJzeXMsCisJCQkJICAgc3RydWN0IG52bWV0X2N0cmwgKmN0cmwsCisJCQkJICAgc3RydWN0
IGRldmljZSAqcDJwX2NsaWVudCkKKwlfX211c3RfaG9sZCgmc3Vic3lzLT5sb2NrKQogewog
CXN0cnVjdCBudm1ldF9ucyAqbnM7CiAJdW5zaWduZWQgbG9uZyBpZHg7CiAKLQlsb2NrZGVw
X2Fzc2VydF9oZWxkKCZjdHJsLT5zdWJzeXMtPmxvY2spOworCWxvY2tkZXBfYXNzZXJ0X2hl
bGQoJnN1YnN5cy0+bG9jayk7CiAKIAlpZiAoIXAycF9jbGllbnQpCiAJCXJldHVybjsKQEAg
LTE2MDYsNyArMTU5Niw3IEBAIHN0YXRpYyB2b2lkIG52bWV0X3NldHVwX3AycF9uc19tYXAo
c3RydWN0IG52bWV0X2N0cmwgKmN0cmwsCiAJY3RybC0+cDJwX2NsaWVudCA9IGdldF9kZXZp
Y2UocDJwX2NsaWVudCk7CiAKIAludm1ldF9mb3JfZWFjaF9lbmFibGVkX25zKCZjdHJsLT5z
dWJzeXMtPm5hbWVzcGFjZXMsIGlkeCwgbnMpCi0JCW52bWV0X3AycG1lbV9uc19hZGRfcDJw
KGN0cmwsIG5zKTsKKwkJbnZtZXRfcDJwbWVtX25zX2FkZF9wMnAoc3Vic3lzLCBjdHJsLCBu
cyk7CiB9CiAKIHN0YXRpYyB2b2lkIG52bWV0X3JlbGVhc2VfcDJwX25zX21hcChzdHJ1Y3Qg
bnZtZXRfY3RybCAqY3RybCkKQEAgLTE3NTIsMTMgKzE3NDIsNyBAQCBzdHJ1Y3QgbnZtZXRf
Y3RybCAqbnZtZXRfYWxsb2NfY3RybChzdHJ1Y3QgbnZtZXRfYWxsb2NfY3RybF9hcmdzICph
cmdzKQogCQlnb3RvIGluaXRfcHJfZmFpbDsKIAlsaXN0X2FkZF90YWlsKCZjdHJsLT5zdWJz
eXNfZW50cnksICZzdWJzeXMtPmN0cmxzKTsKIAotCS8qCi0JICogQm90aCBzdWJzeXMtPmxv
Y2sgYW5kIGN0cmwtPnN1YnN5cy0+bG9jayByZWZlcnMgdG8gdGhlIHNhbWUgbG9jay4KLQkg
KiBIb3dldmVyIHRoZXJlJ3Mgbm8gd2F5IGZvciB1cyB0byBhbm5vdGF0ZSBzdWNoIGxvY2tp
bmcgc2VtYW50aWNzCi0JICogdXNpbmcgY2xhbmcgY29udGV4dCBhbm5vdGF0aW9uLiBTbyBl
eHBsaWNpdGx5IGFzc2VydCB0aGUgY2FwYWJpbGl0eS4KLQkgKi8KLQlfX2Fzc3VtZV9jdHhf
bG9jaygmY3RybC0+c3Vic3lzLT5sb2NrKTsKLQludm1ldF9zZXR1cF9wMnBfbnNfbWFwKGN0
cmwsIGFyZ3MtPnAycF9jbGllbnQpOworCW52bWV0X3NldHVwX3AycF9uc19tYXAoc3Vic3lz
LCBjdHJsLCBhcmdzLT5wMnBfY2xpZW50KTsKIAludm1ldF9kZWJ1Z2ZzX2N0cmxfc2V0dXAo
Y3RybCk7CiAJbXV0ZXhfdW5sb2NrKCZzdWJzeXMtPmxvY2spOwogCXVwX3JlYWQoJm52bWV0
X2NvbmZpZ19zZW0pOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5o
IGIvZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5oCmluZGV4IDQxOTEyODc3YWRlMy4uMjcw
Y2IxMTJlNzAyIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmgKKysr
IGIvZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5oCkBAIC0yMDcsOCArMjA3LDkgQEAgc3Rh
dGljIGlubGluZSBzdHJ1Y3QgbnZtZXRfbnMgKnRvX252bWV0X25zKHN0cnVjdCBjb25maWdf
aXRlbSAqaXRlbSkKIAlyZXR1cm4gY29udGFpbmVyX29mKHRvX2NvbmZpZ19ncm91cChpdGVt
KSwgc3RydWN0IG52bWV0X25zLCBncm91cCk7CiB9CiAKLXN0YXRpYyBpbmxpbmUgc3RydWN0
IGRldmljZSAqbnZtZXRfbnNfZGV2KHN0cnVjdCBudm1ldF9ucyAqbnMpCi0JX19tdXN0X2hv
bGQoJm5zLT5zdWJzeXMtPmxvY2spCitzdGF0aWMgaW5saW5lIHN0cnVjdCBkZXZpY2UgKm52
bWV0X25zX2RldihzdHJ1Y3QgbnZtZXRfc3Vic3lzICpzdWJzeXMsCisJCXN0cnVjdCBudm1l
dF9ucyAqbnMpCisJX19tdXN0X2hvbGQoJnN1YnN5cy0+bG9jaykKIHsKIAlyZXR1cm4gbnMt
PmJkZXYgPyBkaXNrX3RvX2Rldihucy0+YmRldi0+YmRfZGlzaykgOiBOVUxMOwogfQo=

--------------qLokLvW35d7oFwP8kdQmI2z9--



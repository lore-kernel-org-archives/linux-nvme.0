Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E0CC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 09:29:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB3A613A9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 09:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB3A613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hkIsEKx3YAE4XHQqkV8Sh3FX6j4rNQQVbLQnzQRPwbY=; b=EkUwI2KB55kvBQVtBlXHeDHpq
	GJY6OCK5UzHvkt4Q38FMV7aMC98ZCt61hSKEmOyCHhL+2ztxF3BE3+++XDfRRleV4+ruQmAZIji2j
	LdU5XQ8/4E4X3NrQe8kCBGRhrOxIynGpVxTXP0C6AhWXd9B/1C4BpMGsqZYhBpYljBtXIIvubfZhD
	8gNrnxgB3BHdNS4bHxCoC9M/PB+IohfeDqqeN0OENE0OoPcZAYUsuyQ4T/R80U33p7xs9vR7NAFYl
	Uy272D/8O9iQmOp5KNCaebVBDH/WgcO30BJXEBJRD3ndomjFRk6DfE5z/PkduvAlwO4utf64imHDV
	twn2Lmgog==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZVe3-00GMne-EW; Thu, 22 Apr 2021 09:29:11 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZVe0-00GMnO-U0
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 09:29:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Sender:In-Reply-To:Content-Type:References:
 Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
 bh=1JbWzdjefGN7j20B212xQP5JZi21xzHeI+2btflqab4=; b=Lul48JZZCD3EIo0Nf+0/EE3US
 y6wjJY+0f7DX6Y2BmDk4RHbiGuEli34KDun7li1kIIxbKu6WVexJSUl526OcCfC7SdXvLxlJR9xQO
 OzuoyuztPhpZXz9igSTAKmWKEDji3n/57DCkM4iOIDYsGB3iU0jlYG0G4ISz9UlRAmwrwu7TG0cUn
 nXgRYhcK6qkDsvT0kbyL0uld0cjm9qH+aLDRBfa9B7ERpk2v4bep57svcc9LOjZMMB7v7dZT3ZT8X
 vwjOwTb9ck1V/M2GvhnVrBJD++VICiqWNL40t+nSjqS+/g1CungP2ebBH4IqG9StK8k0Rg7u5sOW1
 Kybn7daSw==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZVdx-00DXn9-HO
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 09:29:07 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13M94TWx003221; Thu, 22 Apr 2021 05:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to : sender :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1JbWzdjefGN7j20B212xQP5JZi21xzHeI+2btflqab4=;
 b=WFkq3n9APitCPuva54jPcTYCmnePWaaMVJgYzRQrmHEh1G27IjHWWLtVKeOql14RXnJC
 Qr6DU4xdA5D8mpnSS1HuLRNw+BdyGyeh/CLMjrTd+FZiNqCQzsbzfXJAsWGA+nhT4Jx9
 1IvTFngZo+IT+0P5yyVZh2pUS7wydrzwpKnHQLZcSWAWB3R8QKzoczX/71B7wdUOQ2Ec
 Zon6ND/3l/61/eaoJ/wTHzP9lqoMuwRF1P1uXZgnQNPsVyhea+oGKhTZdnoxUF2Hwkf3
 c8Owd5gvUTaEwCe+IusFZtIqnM2XnYg0xP8Wik0lezM4UZDJDUgSMoNZKvrSV6ahhnvz Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3835xxh2wh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Apr 2021 05:28:58 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13M9QbHL094162;
 Thu, 22 Apr 2021 05:28:57 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3835xxh2vs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Apr 2021 05:28:57 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13M9SSSN002294;
 Thu, 22 Apr 2021 09:28:55 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06fra.de.ibm.com with ESMTP id 37ypxh9hgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Apr 2021 09:28:55 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 13M9Sq6o33751446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Apr 2021 09:28:52 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 630EEAE04D;
 Thu, 22 Apr 2021 09:28:52 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F99CAE045;
 Thu, 22 Apr 2021 09:28:52 +0000 (GMT)
Received: from t480-pf1aa2c2.fritz.box (unknown [9.145.88.229])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 22 Apr 2021 09:28:52 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2.fritz.box with local (Exim 4.94)
 (envelope-from <bblock@linux.ibm.com>)
 id 1lZVdj-003dTV-Nv; Thu, 22 Apr 2021 11:28:51 +0200
Date: Thu, 22 Apr 2021 11:28:51 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: James Smart <jsmart2021@gmail.com>
Cc: Muneendra <muneendra.kumar@broadcom.com>, hare@suse.de,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
 Steffen Maier <maier@linux.ibm.com>
Subject: Re: [PATCH v9 07/13] lpfc: vmid: Implements ELS commands for appid
 patch
Message-ID: <YIFB03mLWw+kwNmS@t480-pf1aa2c2.linux.ibm.com>
References: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
 <1617750397-26466-8-git-send-email-muneendra.kumar@broadcom.com>
 <YH7LPd8c4PZa1qFC@t480-pf1aa2c2.linux.ibm.com>
 <d9d57857-83f5-9ff7-a427-0817d37f5f84@gmail.com>
Content-Disposition: inline
In-Reply-To: <d9d57857-83f5-9ff7-a427-0817d37f5f84@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dd4WCXQNUVMu7dc2I3PMVWH1kjJ0BYpp
X-Proofpoint-ORIG-GUID: vGnu596I2-D4GZlAZJx2yQqbIsamp9_O
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-22_01:2021-04-21,
 2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104220076
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_022905_850612_203E35E1 
X-CRM114-Status: GOOD (  38.30  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 21, 2021 at 03:55:15PM -0700, James Smart wrote:
> On 4/20/2021 5:38 AM, Benjamin Block wrote:
> ...
> > > +	len =3D *((u32 *)(pcmd + 4));
> > > +	len =3D be32_to_cpu(len);
> > > +	memcpy(vport->qfpa_res, pcmd, len + 8);
> > > +	len =3D len / LPFC_PRIORITY_RANGE_DESC_SIZE;
> > > +
> > > +	desc =3D (struct priority_range_desc *)(pcmd + 8);
> > > +	vmid_range =3D vport->vmid_priority.vmid_range;
> > > +	if (!vmid_range) {
> > > +		vmid_range =3D kcalloc(MAX_PRIORITY_DESC, sizeof(*vmid_range),
> > > +				     GFP_KERNEL);
> > > +		if (!vmid_range) {
> > > +			kfree(vport->qfpa_res);
> > > +			goto out;
> > > +		}
> > > +		vport->vmid_priority.vmid_range =3D vmid_range;
> > > +	}
> > > +	vport->vmid_priority.num_descriptors =3D len;
> > > +
> > > +	for (i =3D 0; i < len; i++, vmid_range++, desc++) {
> > > +		lpfc_printf_vlog(vport, KERN_DEBUG, LOG_ELS,
> > > +				 "6539 vmid values low=3D%d, high=3D%d, qos=3D%d, "
> > > +				 "local ve id=3D%d\n", desc->lo_range,
> > > +				 desc->hi_range, desc->qos_priority,
> > > +				 desc->local_ve_id);
> > > +
> > > +		vmid_range->low =3D desc->lo_range << 1;
> > > +		if (desc->local_ve_id =3D=3D QFPA_ODD_ONLY)
> > > +			vmid_range->low++;
> > > +		if (desc->qos_priority)
> > > +			vport->vmid_flag |=3D LPFC_VMID_QOS_ENABLED;
> > > +		vmid_range->qos =3D desc->qos_priority;
> > =

> > I'm curios, if the FC-switch signals it supports QoS for a range here, =
how
> > exactly interacts this with the VM IDs that you seem to allocate
> > dynamically during runtime for cgroups that request specific App IDs?
> > You don't seem to use `LPFC_VMID_QOS_ENABLED` anywhere else in the
> > series. >
> > Would different cgroups get different QoS classes/guarantees depending
> > on the selected VM ID (higher VM ID gets better QoS class, or something
> > like that?)? Would the tagged traffic be handled differently than the
> > ordinary traffic in the fabric?
> =

> The simple answer is there is no interaction w/ the cgroup on priority.
> And no- we really don't look or use it.  The ranges don't really have hard
> priority values. The way it works is that all values within a range is
> equal; a value in the first range is "higher priority" than a value in the
> second range; and a value in the second range is higher than those in the
> third range, and so on. =


Ah. That's interesting. I thought it is like that, but wasn't sure from
the spec. Thanks for clarifying.

> Doesn't really matter whether the range was marked
> Best Effort or H/M/L. There's no real "weight".
> =

> What you see is the driver simply recording the different ranges so that =
it
> knows what to allocate from later on. The driver creates a flat bitmap of
> all possible values (max of 255) from all ranges - then will allocate val=
ues
> on a first bit set basis.  I know at one point we were going to only
> auto-assign if there was 1 range, and if multiple range was going to defe=
r a
> mgmt authority to tell us which range, but this obviously doesn't do that.

I was worrying a bit whether this would create some hard to debug
problems in the wild, when QoS essentially depends on the order in which
Applications/Containers are started and get IDs assigned accordingly -
assuming there is multiple priority ranges.

> Also... although this is coded to support the full breadth of what the
> standard allows, it may well be the switch only implements 1 range in
> practice.
> =


-- =

Best Regards, Benjamin Block  / Linux on IBM Z Kernel Development / IBM Sys=
tems
IBM Deutschland Research & Development GmbH    /    https://www.ibm.com/pri=
vacy
Vorsitz. AufsR.: Gregor Pillen         /        Gesch=E4ftsf=FChrung: Dirk =
Wittkopp
Sitz der Gesellschaft: B=F6blingen / Registergericht: AmtsG Stuttgart, HRB =
243294

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

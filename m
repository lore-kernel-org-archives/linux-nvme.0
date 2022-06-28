Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B241C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jun 2022 09:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u42EH2xjEJ6rwUJKlk/H8Z6cxIiCb9tJ4OBHylA1C/U=; b=Q9nOhnWhPb8EcQjWObkshbHnu4
	ZFTt5fegaXCaEhfhahyasCM/145VMJS+apTXvTJMqHtXm2lf/mBaG8qi/UBhd+HcjWVkdrGrQCL1N
	P5yjeKn4KC6hZIIo2rQL+hVpc96r7I3lvImO4nTxseTPdSp+hAxCvrZgGRXxWJ9Ryjpc4lMPdMfOf
	z5eqtsIRZj9ysbzpsncalYYjpw4FJh9jqze3Vex1aMWJSsCXVib96Iv+VD7rHmQhTfd/sT3O7zNXR
	Ca7K4zVPttdLsn/c5D7tME6GvV5uhtrXIndJ8j+EvFJP9HznTnBUEdFwPA+4y9aCfXa6XAXJfExv4
	TUoM4f2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o675W-005QMF-RC; Tue, 28 Jun 2022 09:00:50 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o675T-005QJT-PM
	for linux-nvme@lists.infradead.org; Tue, 28 Jun 2022 09:00:49 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S8B0lt026386;
	Tue, 28 Jun 2022 09:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=u42EH2xjEJ6rwUJKlk/H8Z6cxIiCb9tJ4OBHylA1C/U=;
 b=d2Ky6hFvuyAoSFbOrAk2p+TtE0jzeXdl6RdVCwXMP5OJzIl0y4czCMbbg5aSu6igLnGF
 2bVe7YmEvoA9FJsOOg+2KeXotweBnWpnWk15RvLFhsvsYwhmUF8j6siuICK5lb7n/WBV
 2KpCVHq4UCoz0OpAENOl0hPgYl9oquwa/1wD6PY1B3MDKyf6yeElBfjRgcje6b03dysX
 HNoY8i3J6/P4wRq39Pl0SmicUrMOiXRj1yftwyxFZac0vlm21Xqj7qmWV+baGuAx8p6h
 e47ZMPv0jHeLRXCh+CaoGn/zXYrjFP9XL/LowuBp10+35vJR6nUEstOpL0FqW5QHfyrb Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gywknhhre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jun 2022 09:00:36 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25S8Hew9027550;
	Tue, 28 Jun 2022 09:00:36 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gywknhhq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jun 2022 09:00:36 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25S8o3uw031460;
	Tue, 28 Jun 2022 09:00:33 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma04fra.de.ibm.com with ESMTP id 3gwt093c82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jun 2022 09:00:33 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25S8xV6o23789828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jun 2022 08:59:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 701E911C052;
	Tue, 28 Jun 2022 09:00:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF97811C054;
	Tue, 28 Jun 2022 09:00:29 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.152.224.212])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jun 2022 09:00:29 +0000 (GMT)
Date: Tue, 28 Jun 2022 11:00:24 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Eric Farman <farman@linux.ibm.com>, Keith Busch <kbusch@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>, axboe@kernel.dk,
        Kernel Team
 <Kernel-team@fb.com>, hch@lst.de, bvanassche@acm.org,
        damien.lemoal@opensource.wdc.com, ebiggers@kernel.org,
        pankydev8@gmail.com, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Message-ID: <20220628110024.01fcf84f.pasic@linux.ibm.com>
In-Reply-To: <YrnOmOUPukGe8xCq@kbusch-mbp.dhcp.thefacebook.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
	<20220610195830.3574005-12-kbusch@fb.com>
	<ab1bc062b4a1d0ad7f974b6068dc3a6dbf624820.camel@linux.ibm.com>
	<YrS2HLsYOe7vnbPG@kbusch-mbp>
	<YrS6/chZXbHsrAS8@kbusch-mbp>
	<e2b08a5c452d4b8322566cba4ed33b58080f03fa.camel@linux.ibm.com>
	<e0038866ac54176beeac944c9116f7a9bdec7019.camel@linux.ibm.com>
	<c5affe3096fd7b7996cb5fbcb0c41bbf3dde028e.camel@linux.ibm.com>
	<YrnOmOUPukGe8xCq@kbusch-mbp.dhcp.thefacebook.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q539bD5qlxHp31I-mVP_n6Bd_mL0VhZm
X-Proofpoint-ORIG-GUID: yci596-An6ilTeIcr4O5QXtwHd8zo27z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_09,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280035
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_020047_866915_0D7B13DA 
X-CRM114-Status: GOOD (  32.12  )
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

On Mon, 27 Jun 2022 09:36:56 -0600
Keith Busch <kbusch@kernel.org> wrote:

> On Mon, Jun 27, 2022 at 11:21:20AM -0400, Eric Farman wrote:
> > 
> > Apologies, it took me an extra day to get back to this, but it is
> > indeed this pass through that's causing our boot failures. I note that
> > the old code (in iomap_dio_bio_iter), did:
> > 
> >         if ((pos | length | align) & ((1 << blkbits) - 1))
> >                 return -EINVAL;
> > 
> > With blkbits equal to 12, the resulting mask was 0x0fff against an
> > align value (from iov_iter_alignment) of x200 kicks us out.
> > 
> > The new code (in iov_iter_aligned_iovec), meanwhile, compares this:
> > 
> >                 if ((unsigned long)(i->iov[k].iov_base + skip) &
> > addr_mask)
> >                         return false;
> > 
> > iov_base (and the output of the old iov_iter_aligned_iovec() routine)
> > is x200, but since addr_mask is x1ff this check provides a different
> > response than it used to.
> > 
> > To check this, I changed the comparator to len_mask (almost certainly
> > not the right answer since addr_mask is then unused, but it was good
> > for a quick test), and our PV guests are able to boot again with -next
> > running in the host.  
> 
> This raises more questions for me. It sounds like your process used to get an
> EINVAL error, and it wants to continue getting an EINVAL error instead of
> letting the direct-io request proceed. Is that correct? 

Is my understanding as well. But I'm not familiar enough with the code to
tell where and how that -EINVAL gets handled.

BTW let me just point out that the bounce buffering via swiotlb needed
for PV is not unlikely to mess up the alignment of things. But I'm not
sure if that is relevant here.

Regards,
Halil

> If so, could you
> provide more details on what issue occurs with dispatching this request?
> 
> If you really need to restrict address' alignment to the storage's logical
> block size, I think your storage driver needs to set the dma_alignment queue
> limit to that value.



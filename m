Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8EECF34DA
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oabmjwwBhK+1RvtVe37+0jgCkNh8OinfObvsO8jCIwI=; b=fTy4/73XkekAVNIo17syY0Hk4f
	b7OMM8fsZBTGRwyeujWIpYQLthHcVnQ4y6CkiYB5nlDFIcu90xQEphC/T5gMis1l0btGcICxXildb
	uhRzoktyXNWRsDJuHFv44H5NBASA9IrosU/4zBKbn81X74vAtbpj1tfb7BOODKpH21RWAG9S2GBp2
	WlxVJuCjHYIKDzandS0vv2iBSli8gS9M/8Kp+URRqcL8FxWkSCF7iknynPu+5eqML79eW4cxx2tD3
	2IVLONm5FH6RdpZSXRrjTqqDDrDGAyt+UhCZ1WfGYCKrhac4wQjzTQAf4YCmn7ugySqAVpvqqNVA9
	rOWmjEAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swVMb-0000000Ad44-1743;
	Thu, 03 Oct 2024 23:36:05 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swVMP-0000000Ad2h-3Fun
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 23:35:55 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493NKHp6029546;
	Thu, 3 Oct 2024 23:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:reply-to:to:cc:date:in-reply-to
	:references:content-type:content-transfer-encoding:mime-version;
	 s=pp1; bh=oabmjwwBhK+1RvtVe37+0jgCkNh8OinfObvsO8jCIwI=; b=BYAgC
	kFvJZzfjzUAROsLMgTgqS5hfYcYF7qWsvjuRA/SiNoFwMP0njWKMKxGUIQ0xkAoF
	wjvXcpIOWZ+GWItvZ6IZJyPKelJlR4WMsN0tyfImkPYrGRw4+FgsI7JKwClAhRQx
	u5oM+VoI2Scn9QaCBBULc0ApGzxeF54rhE8bcb3ZHjsVTwcUDGcbWs1/MEp35WUr
	bPbvwATsIqrfeweRhGJtS98LbVvW40vzQTchl6JPOhJwe+YZI+Ge67deoguwa0hl
	/BdTP5bHhrJ2Z4uv2j6Ct97/NHrbrpULak/Uu335oBTfrhVGBE+6cOUR8w0QN88D
	MEsEsiM16j3PSbAqA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4224uu8198-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 23:35:34 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 493NZX6W024174;
	Thu, 3 Oct 2024 23:35:33 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4224uu8195-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 23:35:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 493Lr2HK017902;
	Thu, 3 Oct 2024 23:35:32 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42207j96at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 23:35:32 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 493NZV4k44564906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Oct 2024 23:35:31 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95B0C58052;
	Thu,  3 Oct 2024 23:35:31 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CF5358045;
	Thu,  3 Oct 2024 23:35:31 +0000 (GMT)
Received: from rhel-laptop.ibm.com (unknown [9.61.135.55])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Oct 2024 23:35:30 +0000 (GMT)
Message-ID: <fd5ebec0dc273afd5d748a26c999254d3ed28f01.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] nvme: retry security commands if media not ready
From: Greg Joyce <gjoyce@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
        sagi@grimberg.me, hare@suse.de, dwagner@suse.de, msuchanek@suse.de,
        jonathan.derrick@linux.dev, okozina@redhat.com, nilay@linux.ibm.com
Date: Thu, 03 Oct 2024 18:35:30 -0500
In-Reply-To: <20241003144106.GA24422@lst.de>
References: <20240930164845.8406-1-gjoyce@linux.ibm.com>
	 <20240930164845.8406-2-gjoyce@linux.ibm.com>
	 <20241002081633.GA22436@lst.de>
	 <dbfd87e4900bea3a28ac46f5abcfb39ef2c13fc1.camel@linux.ibm.com>
	 <20241003124345.GA16754@lst.de>
	 <3876a795bbaa8cef46ed0cb84f8eeccc5462f075.camel@linux.ibm.com>
	 <20241003144106.GA24422@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s6HbiC-kyNW1S5CFwCoDc2Uvb1zGdC7B
X-Proofpoint-ORIG-GUID: HENOiOLuYxZrMzOzeU7FL6jj-hqBB2Ne
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_19,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 mlxlogscore=817 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410030160
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_163554_055860_E6220AF5 
X-CRM114-Status: GOOD (  23.08  )
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
Reply-To: gjoyce@linux.ibm.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2024-10-03 at 16:41 +0200, Christoph Hellwig wrote:
> On Thu, Oct 03, 2024 at 08:30:21AM -0500, Greg Joyce wrote:
> > Thanks. I think that leads me to ask a larger question. If we
> > always
> > wait until media ready,
>=20
> We don't generally wait - the namespaces only become online when they
> are ready, but otherwise we should be up.=C2=A0 Unfortunately the
> technical
> working group allowed some admin command to return media not ready,
> probably to shoe horn existing implementation.=C2=A0 But this generally
> is a bad quality of implementation and there is no good reason for it
> if the little bit of media used by these comes from a separate pool
> that doesn't take as long to recover.=C2=A0 Or in other words, if you see
> this error someonone at IBM messed up writing their purchase spec..
>=20

I agree, I wonder about the value/wisdom of the CC.CRIME capability
especially since there is no way to read status that indicates that the
media is ready for the Figure 103 commands. But it is a defined feature
and setting it does cause CSTS.RDY to be asserted before the media is
ready.

The Kioxia CM7 drive does set both CRWMS and CRIMS (CRMS=3D11b). And
these lines in the NVMe driver thus set CC.CRIME:

        if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap &           =20
NVME_CAP_CRMS_CRIMS)
                ctrl->ctrl_config |=3D NVME_CC_CRIME;

After reading more of the spec and driver code and discussions here, I
suggest that those two lines be removed. This has the effect of
returning to the NVMe version 1.4 behavior and CSTS.RDY will not be
asserted until the media is ready for commands.

Greg


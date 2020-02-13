Return-Path: <SRS0=WUqE=4B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE872C352A4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 03:02:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF72120873
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 03:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QcXkFmjQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uQ+dyeDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF72120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OVXLH95tfq03OVtBT8tj2iYAlEkqnDld0rwKp+UTP4A=; b=QcXkFmjQiKokA1
	RrqxcZ3IsK7/woG8oQUXBQ5ie6OLgKLi9l8s9oim7edGcmFHsgOamLYTEIepNBr+xASwQXYjjpfOl
	/thaf+sbteTjiXzr4OOL3Kk+eAF7mBYe2XW8nVotLF89Tnn77IYcHF3LOylpfTjO+saRjFyZIVKWh
	OqmpRTJCx8/ijVHf4nbpYKKUiD0PJw1rVi2Vy9bc3E2XTjmOHsceiOSk+tgXdrKJXvagFe3F4sZnM
	FEcTqUAjgMzTttBOIpHw+qc+UNOmWwrv4b4565r/RdNdTt04ZB4JSsv3r60few3TEuqMIJEu92Vh0
	adRYzb4EqsDsj2lOhGcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j24lg-0004wK-Cs; Thu, 13 Feb 2020 03:02:20 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j24ld-0004vm-Q7
 for linux-nvme@lists.infradead.org; Thu, 13 Feb 2020 03:02:19 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01D32AML195412;
 Thu, 13 Feb 2020 03:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=LLzhfUkTLcL96RVaoKPShnmZ7NANy0fpYjkZKVROifY=;
 b=uQ+dyeDmJ6wPB5pK3LGgE+pkKrektaFXz12MHSbeXZ1YNpX7gdnisgU37ThSWTodnpNc
 RJofHafsz1l3FnDPvIhVsC8w8g2R8yirzlFyjOcBEAe6dHDrg+QGI7pHV1qqBQmBNWlK
 19ZwNHRjJOk7X3p/xxEJ/eDXh3v5ntp7sN8qztebQTTXlV86hi/wBUDvf8U3XqEwHEaS
 +gp4SHKAx/SNv9OvkOIS0WvZYZzp6S1SBGaVmwA+YziNs0buIiUtcvFn2j3wyVb1kq4U
 lQyo05Glgk3nXPbxDeHJ6TKOFLIGA3nvma6Bc1FiV9dw9pGxAb9ewfRdfqyvnTT0ud33 MA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2y2p3spnhg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Feb 2020 03:02:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01D2vIjw131601;
 Thu, 13 Feb 2020 03:02:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2y4k9gxatq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2020 03:02:15 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01D32CWN010378;
 Thu, 13 Feb 2020 03:02:13 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 12 Feb 2020 19:02:11 -0800
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
 <20200211122821.GA29811@ming.t460p>
 <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
 <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
Date: Wed, 12 Feb 2020 22:02:08 -0500
In-Reply-To: <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
 (Damien Le Moal's message of "Wed, 12 Feb 2020 01:47:53 +0000")
Message-ID: <yq1blq3rxzj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1011
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130023
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200212_190217_886202_373C083D 
X-CRM114-Status: GOOD (  18.00  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Tim Walker <tim.t.walker@seagate.com>, linux-scsi <linux-scsi@vger.kernel.org>,
 Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Damien,

> Exposing an HDD through multiple-queues each with a high queue depth
> is simply asking for troubles. Commands will end up spending so much
> time sitting in the queues that they will timeout.

Yep!

> This can already be observed with the smartpqi SAS HBA which exposes
> single drives as multiqueue block devices with high queue depth.
> Exercising these drives heavily leads to thousands of commands being
> queued and to timeouts. It is fairly easy to trigger this without a
> manual change to the QD. This is on my to-do list of fixes for some
> time now (lacking time to do it).

Controllers that queue internally are very susceptible to application or
filesystem timeouts when drives are struggling to keep up.

> NVMe HDDs need to have an interface setup that match their speed, that
> is, something like a SAS interface: *single* queue pair with a max QD
> of 256 or less depending on what the drive can take. Their is no
> TASK_SET_FULL notification on NVMe, so throttling has to come from the
> max QD of the SQ, which the drive will advertise to the host.

At the very minimum we'll need low queue depths. But I have my doubts
whether we can make this work well enough without some kind of TASK SET
FULL style AER to throttle the I/O.

> NVMe specs will need an update to have a "NONROT" (non-rotational) bit in
> the identify data for all this to fit well in the current stack.

Absolutely.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

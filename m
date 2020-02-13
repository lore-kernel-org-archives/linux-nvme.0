Return-Path: <SRS0=WUqE=4B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57620C352A3
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 04:17:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D1F2073C
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 04:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aAm2cJYF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iuJEyONS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D1F2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o9YaN9fwpogh6kWd4NG+A67wlwR2t7JpmINOPbRH0qE=; b=aAm2cJYF3g45KI
	aqUeIJcgH8vb6edn6pjEuHiq3AsAKemt/1llFTrbipokn8Egr3LICLfEIKK9Xnh0tyYWGjcNVZ6/Z
	R5mp5Nnnv2EDsQA4lfRiyKzEdzH8GrEoBdiAy5JpefRc54HMRsohHassotgdL5mJoDBwYbDwc1VX9
	2GXCPE0Rdqm3XVdWfIt/KowJ/9FvSHvdOMu9QErZzTdGUygAFo359H5evagJJDtVpc6sOvpXqFfbS
	47akhr/VE/84G0VNHZvmQQLqQWbF60k4jR3U6p/ZXFf4ria4u7Ky+zO4NoRAeNzrLJwKNuHHgAXvW
	k7xdSVPltwyCIlPO/DHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j25w6-0003WV-Qn; Thu, 13 Feb 2020 04:17:10 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j25w3-0003W8-T4
 for linux-nvme@lists.infradead.org; Thu, 13 Feb 2020 04:17:09 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01D49A0l002900;
 Thu, 13 Feb 2020 04:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=+E+GllyTG9PBTs0Otk6DgALwahzxRyV7OBkh64owcPs=;
 b=iuJEyONSvWF3OrCLcyLVAgmUZbk+WfbqPdWxh09YnCSyL0Vi5e63QeqHkiUdw83urnXW
 3DDa6EBiECTZAz30uTcBsHiSRLZlqySlQfqQD3OhzCzUoy3VMKTxGWPGtTyYGMlF5cBD
 VyutPhKpeb3gawXo0tkcn4xjiXnU1NRaL5xT80XhrjpHroTqsit61+l4szXeeSQqwpeD
 yFsnvQ9tK2xUrie24l2CxwztpiIjSsXaOt0Jl2D8XBaTJqkQHSgYyuxzoJ1lRsVjUMo+
 44xSovduSWGcL83MmZ8ga05QrHpAOyZr3iX4XETTu8FsG2bM267cDq1VTfg4iTv0l0VG Kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2y2p3spv62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Feb 2020 04:17:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01D47msM025637;
 Thu, 13 Feb 2020 04:17:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2y4k7xy1xf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2020 04:17:05 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01D4H3DV014670;
 Thu, 13 Feb 2020 04:17:03 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 12 Feb 2020 20:17:03 -0800
To: Tim Walker <tim.t.walker@seagate.com>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
 <20200211122821.GA29811@ming.t460p>
 <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
 <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <yq1blq3rxzj.fsf@oracle.com>
 <CANo=J16cDBUDWdV7tdY33UO0UT0t-g7jRfMVTxZpePvLew7Mxg@mail.gmail.com>
Date: Wed, 12 Feb 2020 23:17:00 -0500
In-Reply-To: <CANo=J16cDBUDWdV7tdY33UO0UT0t-g7jRfMVTxZpePvLew7Mxg@mail.gmail.com>
 (Tim Walker's message of "Wed, 12 Feb 2020 22:12:48 -0500")
Message-ID: <yq1r1yzqfyb.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130031
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200212_201708_022307_B79B6B29 
X-CRM114-Status: GOOD (  17.86  )
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
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ming Lei <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Tim,

> SAS currently supports QD256, but the general consensus is that most
> customers don't run anywhere near that deep. Does it help the system
> for the HD to report a limited (256) max queue depth, or is it really
> up to the system to decide many commands to queue?

People often artificially lower the queue depth to avoid timeouts. The
default timeout is 30 seconds from an I/O is queued. However, many
enterprise applications set the timeout to 3-5 seconds. Which means that
with deep queues you'll quickly start seeing timeouts if a drive
temporarily is having issues keeping up (media errors, excessive spare
track seeks, etc.).

Well-behaved devices will return QF/TSF if they have transient resource
starvation or exceed internal QoS limits. QF will cause the SCSI stack
to reduce the number of I/Os in flight. This allows the drive to recover
from its congested state and reduces the potential of application and
filesystem timeouts.

> Regarding number of SQ pairs, I think HDD would function well with
> only one. Some thoughts on why we would want >1:

> -A priority-based SQ servicing algorithm that would permit
> low-priority commands to be queued in a dedicated SQ.
> -The host may want an SQ per actuator for multi-actuator devices.

That's fine. I think we're just saying that the common practice of
allocating very deep queues for each CPU core in the system will lead to
problems since the host will inevitably be able to queue much more I/O
than the drive can realistically complete.

> Since NVMe doesn't guarantee command execution order, it seems the
> zoned block version of an NVME HDD would need to support zone append.
> Do you agree?

Absolutely!

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

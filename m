Return-Path: <SRS0=WUqE=4B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD202C352A4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 03:13:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE1720724
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 03:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OD8UibzL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seagate.com header.i=@seagate.com header.b="sT7GX9hW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seagate.com header.i=@seagate.com header.b="UwSOsUEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE1720724
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=seagate.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+DWVhR3pqsABn04SrqC1/ZqPJSDSI8Osp3ey01Y4ZeY=; b=OD8UibzL1bTAM0
	m2QzvLYHdmU/STrx4CLiiNyygUvFvayGy70BHh66rRhVhuoxuqhyu+6B2qfxzPzHg/UY50W6juZSg
	RmwbwDRHWP7+DOs3KziPWyl7g/9VElAT7zPRmzbf252fOUFa+CVLNYyUmd/L9aPTBBseCiBqu2CSM
	7pZwMqTcw6MQuOK9o93hpxhOtmfBtzYWTp4A+rxsfnOblxatMejbeFMtuKaTREAXElMChTkvkjOYP
	TtcsIJUGdIskSLwTdRfXlpHcZQEm0cSPqrgF3piYFfdeZ/fTiOHY6pqhuwAOSydQ3PpuzEDh5r48v
	w5Dunad+X2DyT9JftmUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j24w9-0000gR-S7; Thu, 13 Feb 2020 03:13:09 +0000
Received: from mx0a-00003501.pphosted.com ([67.231.144.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j24w5-0000f9-Iz
 for linux-nvme@lists.infradead.org; Thu, 13 Feb 2020 03:13:07 +0000
Received: from pps.filterd (m0075555.ppops.net [127.0.0.1])
 by mx0a-00003501.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01D34u1r022040
 for <linux-nvme@lists.infradead.org>; Wed, 12 Feb 2020 22:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=proofpoint;
 bh=aeRDRytmjUxMR4R/7zSm4XSSyOBaq5LlOPitnTdrdUc=;
 b=sT7GX9hWtVbvQllqQGubfW4gpVrtrI4b0mVJDQpJk5BvSOUjyCfKxe8Q6MmV5mCSGVY7
 0q1VWqBuBWHCT8jY+nPMy/0AfVQw60DqaEjVzNUXMjyl54tVEIKcvOQbP4DGRlPDhbdJ
 H5xAP8jmzQft/7AHlLSKQTZjgCB6YLY6U3Ntn2SUr+/JIqsW22HWOHr4Fs9tq1L/eDp0
 AQ9YYeEZDV8ZXIuEm8q+8dv3jLJvP2cccB1S6xCsaRRNc7lOuHd5aAWyYmdqpVW7I/CZ
 th8+9z8HccpvLBGfFzL1H9TPEC647ullpsWpiXuFT1lUKIcJbRuG9RLaEy+nFGjPqX98 tg== 
Authentication-Results: seagate.com;
 dkim=pass header.d=seagate.com header.s=google
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 by mx0a-00003501.pphosted.com with ESMTP id 2y2ar63prx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Wed, 12 Feb 2020 22:13:02 -0500
Received: by mail-wm1-f72.google.com with SMTP id t17so1483138wmi.7
 for <linux-nvme@lists.infradead.org>; Wed, 12 Feb 2020 19:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aeRDRytmjUxMR4R/7zSm4XSSyOBaq5LlOPitnTdrdUc=;
 b=UwSOsUExMjS/94lWRUhTH9yzR2CUuf4WjA7nIIQcNPWQ85Ag3w775ibW95ngKz3FO9
 1VysFDpCmNOzW9KbOw4cTaf5RsPVmnqic+UDWofY+6OyFw3VZv1XFZX7fe4IsD1VTG9S
 bhjh0n9BTNhfu9r1cEpO1DgJYWiuJ0I6BEYZkigkc7z9AcwMimISNs5X7woby/Vt1yKR
 0LIKD5U3oxAmxfgOUXz+qhHp3cqM3vsxxso6Gn00YFRVDAnVxMEoJr6/aKeIut9gPTYp
 KFoFvLTbyHs8G+Kibh4Ytj0GRvLxO8ncJcIsj5xXjJtsihdVxvwdquyCP5EzdzxxVOpq
 ib/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aeRDRytmjUxMR4R/7zSm4XSSyOBaq5LlOPitnTdrdUc=;
 b=Vqddohe8QrVKkqEN5dnMTHiag/C6EnRoOpF+rGU+oLsFlwGspd0EAhiyA0QDX1XI1v
 pRAPXngf/Z2vmPB3puagf1JswlZ0d77Pv4RXLrkyWKq0yonLflVAvOBUmELEnGf9foH9
 JU56YNZGQtzMm5skJkAkdOWZT/k3pfdAT9eqr4RYtSGq0HJysykgcafcUfaw5IMLQK6X
 P226gDanGldyn7NSvk5a3/jTkBWqDcm74kVFUQ5UMUHSvGaQCf8OZRe7bN5mKbehjGBp
 TCJY0cTKNpP/Xub1Y8DNStPaC7wgSwj5+lOYDTDzUIjcMQwjaCKNwdatQxv46HUF89eg
 Q5mQ==
X-Gm-Message-State: APjAAAXjzKTJNlcCGkG1SC8KdMPvtSd3OeGVBbm0uawNsQIpMjJRfxow
 R/+pnjMj65Bw66utg9Rchn/rzjRQaFIWLnPn0RTvWZ4iVTYsEDRhs2GVAd7IUY0X2RTRm3yBgRd
 nfbbiSc3k2JsJx03MaGBWK8p7I0CAiV0V+4/ihx8nfkmThNUcuOa29o4Vs1G3hLbOLKj0
X-Received: by 2002:a1c:39d7:: with SMTP id g206mr2718841wma.111.1581563580560; 
 Wed, 12 Feb 2020 19:13:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqybjxFdSjprgwYZrF75D1xoH7KGu1PhRJqaE7+0aWDRg5D8u6mQWhAEWh3emC6n7MbmGjAh0f9wt+SbTn5te2g=
X-Received: by 2002:a1c:39d7:: with SMTP id g206mr2718799wma.111.1581563580199; 
 Wed, 12 Feb 2020 19:13:00 -0800 (PST)
MIME-Version: 1.0
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
 <20200211122821.GA29811@ming.t460p>
 <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
 <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <yq1blq3rxzj.fsf@oracle.com>
In-Reply-To: <yq1blq3rxzj.fsf@oracle.com>
From: Tim Walker <tim.t.walker@seagate.com>
Date: Wed, 12 Feb 2020 22:12:48 -0500
Message-ID: <CANo=J16cDBUDWdV7tdY33UO0UT0t-g7jRfMVTxZpePvLew7Mxg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
To: "Martin K. Petersen" <martin.petersen@oracle.com>
X-Proofpoint-PolicyRoute: Outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-12_10:2020-02-12,
 2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=1
 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130024
X-Proofpoint-Spam-Policy: Default Domain Policy
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200212_191306_551581_BD23259D 
X-CRM114-Status: GOOD (  22.30  )
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
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-scsi <linux-scsi@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 12, 2020 at 10:02 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Damien,
>
> > Exposing an HDD through multiple-queues each with a high queue depth
> > is simply asking for troubles. Commands will end up spending so much
> > time sitting in the queues that they will timeout.
>
> Yep!
>
> > This can already be observed with the smartpqi SAS HBA which exposes
> > single drives as multiqueue block devices with high queue depth.
> > Exercising these drives heavily leads to thousands of commands being
> > queued and to timeouts. It is fairly easy to trigger this without a
> > manual change to the QD. This is on my to-do list of fixes for some
> > time now (lacking time to do it).
>
> Controllers that queue internally are very susceptible to application or
> filesystem timeouts when drives are struggling to keep up.
>
> > NVMe HDDs need to have an interface setup that match their speed, that
> > is, something like a SAS interface: *single* queue pair with a max QD
> > of 256 or less depending on what the drive can take. Their is no
> > TASK_SET_FULL notification on NVMe, so throttling has to come from the
> > max QD of the SQ, which the drive will advertise to the host.
>
> At the very minimum we'll need low queue depths. But I have my doubts
> whether we can make this work well enough without some kind of TASK SET
> FULL style AER to throttle the I/O.
>
> > NVMe specs will need an update to have a "NONROT" (non-rotational) bit in
> > the identify data for all this to fit well in the current stack.
>
> Absolutely.
>
> --
> Martin K. Petersen      Oracle Linux Engineering
Hi all-

We already anticipated the need for the "spinning rust" bit, so it is
already in place (on paper, at least).

SAS currently supports QD256, but the general consensus is that most
customers don't run anywhere near that deep. Does it help the system
for the HD to report a limited (256) max queue depth, or is it really
up to the system to decide many commands to queue?

Regarding number of SQ pairs, I think HDD would function well with
only one. Some thoughts on why we would want >1:
-A priority-based SQ servicing algorithm that would permit
low-priority commands to be queued in a dedicated SQ.
-The host may want an SQ per actuator for multi-actuator devices.
There may be others that I haven't thought of, but you get the idea.
At any rate, the drive can support as many queue-pairs as it wants to
- we can use as few as makes sense.

Since NVMe doesn't guarantee command execution order, it seems the
zoned block version of an NVME HDD would need to support zone append.
Do you agree?

-- 
Tim Walker
Product Design Systems Engineering, Seagate Technology
(303) 775-3770

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

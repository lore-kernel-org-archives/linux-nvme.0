Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C983C433E2
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 15:15:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20762075E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 15:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u1phDZWB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd1BNDBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20762075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CG9eMPdCC8W7PuJrxZP3aBu1vuHRNhE4kY3NGtfPt/o=; b=u1phDZWBzGSMd13g7ckyivx5k
	EIO9Cv89ior1wbYAWMxz40GTXFdHnG5vygurpWvZr16yoATJ5bb9v6X7vtfiEK8ZDGof8pYZiEbXP
	qxFSu6DFyZpPhle5FMqjWlPj+MU3C20Wea4OrhQmVMG5/7PRb7lBZ+2+mRJxsv4F8pUXzAEliboMs
	KmjhynI/jXU6RDeCiZiiX/dclS79L3OuR8ShMXkeM0uiGHS4+jUUCEU3By3qvXYIQnpyYyS7OD3jW
	QfFCif5dM8cDjdt8kKM2W9ayzUSKLojvF+tGMM9DOqKTHrTRt9s5wtL8WsEQpAc04XyThEVly3CYj
	9zanurPzA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGkm3-0002nP-F8; Fri, 11 Sep 2020 15:15:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGkm0-0002mp-DR
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 15:15:37 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DDACC2075E;
 Fri, 11 Sep 2020 15:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599837335;
 bh=A67sjC+z92I8aelXIvxLW2QZk1L+YSJjaaecKK+2DaE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Nd1BNDBtith5V+fhA5lnUXxQMJQJWNbBQTuFZ4h/EiYnY15favz1LJJjBOK74GwE3
 rPqcerKw74+W/vH1OE2puu7t4oR7V2ABO29PyUprYddv6LfeedJE/ieAZ+Vy6jxH0L
 XWmvk+8Yj9Squ/fmR3qSUesLadzNuE/X4q2vmhnY=
Date: Fri, 11 Sep 2020 08:15:32 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jeffrey Lien <Jeff.Lien@wdc.com>
Subject: Re: Dual controller sysfs Question
Message-ID: <20200911151532.GA3654975@dhcp-10-100-145-180.wdl.wdc.com>
References: <BYAPR04MB5656A018DD122D37806A8EE2EA240@BYAPR04MB5656.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5656A018DD122D37806A8EE2EA240@BYAPR04MB5656.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_111536_600546_9F334AC2 
X-CRM114-Status: GOOD (  26.19  )
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
Cc: Prathiksha Nayak <Prathiksha@wdc.com>,
 Yuvaraj Hosanthe <Yuvaraj.SH@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Akhilesh Rn <Akhilesh.RN@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 11, 2020 at 02:40:05PM +0000, Jeffrey Lien wrote:
> We need some information on how a dual controller drive should show up in the /sys/block directories with respect to latest 5.4 kernel.
> 
> Below is our observation :
> When tried  a drive in a dual port mode with namespaces attached to it
> using Ubuntu - 5.4.0-45-generic kernel version, we could see all the
> block devices getting listed under 'sys/block'  path but when we check
> for the block device uevent path of the attached namespaces  ( i.e
> /sys/block/nvme0c0n1/uevent) we do not see the DEVNAME details in that
> path but we could see the DEVNAME details for other block devices
> under sys/block. 
>
> There are 2 namespaces created on 2 different controller nvme0 and
> nvme1 and below is the output from sys/block path.
> 
>                   # nvme list
>                    Node             SN                   Model                                    Namespace Usage                      Format           FW Rev
>                    ---------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
>                    /dev/nvme0n1     SDM0000029DA         HUSMR7638BDP3Y1                          2         150.32  GB / 150.32  GB      4 KiB +  0 B   KNGND688
>                    /dev/nvme0n2     SDM0000029DA         HUSMR7638BDP3Y1                          1         103.08  GB / 103.08  GB      4 KiB +  0 B   KNGND688
>                   # ls
>                   loop0  loop1  loop2  loop3  loop4  loop5  loop6  loop7  nvme0c0n1  nvme0c1n2  nvme0n1  nvme0n2  sda
>                   # cat nvme0c0n1/uevent
>                   DEVTYPE=disk

nvme0c0n1 is a "hidden" controller path to a namespace with the native
nvme multipathing enabled. These are not directly accessible from the
user, hence they don't get the same properties.

You should see the events for the sysfs entry under nvme0n1.

>                   # cat loop6/uevent
>                   MAJOR=7
>                   MINOR=6
>                   DEVNAME=loop6
>                   DEVTYPE=disk
> 
> With respect to other kernel version which we tried (i.e SLES with
> 4.4.143-94.47 ) we do not see this kind of behavior and its working
> fine with dual port mode with namespaces attached to it on same drive
> device by getting all the DEVNAME details from uevent path.
> 
> # nvme list
>                Node             SN                   Model                                    Namespace Usage                      Format           FW Rev
>                ---------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
>               /dev/nvme0n1     SDM0000029DA         HUSMR7638BDP3Y1                          2         150.32  GB / 150.32  GB      4 KiB +  0 B   KNGND688
>              /dev/nvme0n2     SDM0000029DA         HUSMR7638BDP3Y1                          1         103.08  GB / 103.08  GB      4 KiB +  0 B   KNGND688
> # ls
> nvme0n1  nvme1n1  sda
> # cat nvme0n1/uevent
> MAJOR=259
> MINOR=1
> DEVNAME=nvme0n1
> DEVTYPE=disk
> #
> 
> Could you please let us know your input on this.  Thanks
> 
> 
> Jeff Lien

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

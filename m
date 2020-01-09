Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73006C32771
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 05:56:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05CAB20678
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 05:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OMosc4v4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MJg+eEY1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NXA76IVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CAB20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=aW2HkchhpC+keGxYjwL3YbE2fXiD6ovm+baeVIR62+8=; b=OMosc4v4KCtBfP
	/N5WXa/Zu7InzG/xW8Okned3kmNXH4nUJRljrBiLWULOmf1v4ozxm2JSisjMWGSbMqe73c4kPep19
	Z+Vubz7lFBnJ2jjhxGkJofUgL58+yzxM00V2fa2dpmBxH6e87BIPbTOvD9AjYY3MjkL65lRnpWeXd
	kjZV4934QTzphgF7D7UPvgaVa6aXCSA2tvEq+pR93vf6vG5+CauOinGUgi0VeBwPuTlY0fcdSZgQw
	c+LZIjiJkNm5KTV/yrwuy6z21ugBeKylm/EXCkwg1UPVBA9atKponApL6NA79JEm9QD7e7J2Sp1II
	0zWkjw3u3z35mFJdNEvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipQnq-0006ui-Ng; Thu, 09 Jan 2020 05:56:18 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipQnn-0006sk-FU
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 05:56:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1578549375; x=1610085375;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ZHEVuzmb4UEKQwjVVJUA3uvW+u0sNLM/oT4nxostcow=;
 b=MJg+eEY1w3WHO79tXu5e6NfRyWt48pvpH/nlk+s3CsMOKbzJjWE1Pn7A
 11FUyRXxSV5/YOogoGGkDdDApYK0TpVad+mDBuzA/+l9kC2In/4jKHkib
 lKjGDcKRzryFw9P4mrpB6knNS5Y1+w5TMY6tXJoU3cfE9XueHfWaiYY/1
 Wwml2mWEfUdrNYktoN+L7NHsI08/tzD2uZ16chcGVsFo1SQt9qrQLot+z
 iwmQZtI10p6o0DYMr8LHfiwryHPBy6/3UZQIDvjpaC6Kvh+VCVjnfxeBc
 l/YdZFN1UsCSSWkA9leBXhcYnrE/mIJj5WH/5tkkygvE195iYHWcE+ije A==;
IronPort-SDR: urxJVJLCyDd+mDzSGckJeoLkOuwP6O5lINwU6xqk4bUtlIYsAdByprxJV2ucVoFngoUO1DuDvj
 ImPQrM80AgLGnNmcd0vzZbQ5g4v3PAmW5+rX46GK8kSkUettoSt6jj6OKdIj2DU2To8ttVZUC/
 x1wXq78gX35lkqnsiBNunbiScWxIlO92jcJF2s1zdTMnA6aaFDY9C7liuesiIgygymKSGAT+/f
 e8y5A53f/VFzfTlcvizhzGi9Cx82l09GE3Xh38ydTDH+R8momFComWtt7SYzgSwgdz7KQhbG5I
 emU=
X-IronPort-AV: E=Sophos;i="5.69,412,1571673600"; d="scan'208";a="128589171"
Received: from mail-bl2nam02lp2054.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.54])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2020 13:56:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a14rCi9/ieKdpjGWaxIGjBKSYakqKmM3WF2g5xbW61k/nhhyHZUSj6PqyHw3ILVrmDaXtSRBz8AMpEqz5heHHzKYKAdiMbq37PdwxxdK07+cfccSUvNz9GhomLLBtckMRaJOLxEcT5mMcEc5FqTYYhanRMNaHSGtL3gztyWGlfe7zetJ6IBLqVx0I7VhhesAL6GOFBEgTUSKFpIw8K2SsTrdnFla7Kgg4LXDFlK2dmnOlyLLSUfWo4h9gSGBLBTiy2VqPkZPsHIgHU/Z3U8qIDx1q1zY1kd9ablNPKNM+/je6RhS6HSCxQ8I6ZDFtcrlGLCCzmjVCGDoiBO3guJyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koKtRxADV1R/sFPrSbfoc5b/Ra0klyuwVaKAmAjcrVg=;
 b=AOtW0mejbgVBKFvTOCkB6jUscpfyVnA9cRvzBqIQDrr29AUW+WxPrlLPtjZStUUxJiMXPWLXOjI4jBeOR8u1b2qE6+4jpg2Pr03xJeUwA+MAWXTGQlbrS521Bn17PxSmxnVuqzWfSqWw5z+cZ4Yi6dSpNdPwJHQppNjzlH0OGirdbn0b6i9x3zP0LEK0lNLRuYM+M1dG3RM4cAcYSM1TWewQjMVYGFp8alTCT8MluAXkgH16RByWWnDXdL32q8TaDg3xKXY3mJ2KyEhm25UbtkyUQfqD26bUK5SXNQO8giO+r/cqO70tlKb00dK/q+Tzz2pcJyzR4NM2Vh3WsdL2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koKtRxADV1R/sFPrSbfoc5b/Ra0klyuwVaKAmAjcrVg=;
 b=NXA76IVNpbd10F3/3ogFw298B78g4y1QBMp6HyUWQDoCUfFIzgPPptUcLD9sy/yJwVnx9T+nvxWxsl4N9BtmGdkhqTysd+N6FNC+RNxjI61To3WV4tU8kkbK8RqpR5QKnyQnIf6oSAJOLnkTbZOCrLrkrJq7TVse3kum2UZwubM=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4104.namprd04.prod.outlook.com (52.135.216.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 05:56:07 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 05:56:07 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, Chaitanya Kulkarni
 <Chaitanya.Kulkarni@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "dm-devel@redhat.com"
 <dm-devel@redhat.com>, "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Topic: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Index: AQHVxYZFlOEpmvYia0KWnm3aEM0giQ==
Date: Thu, 9 Jan 2020 05:56:07 +0000
Message-ID: <BYAPR04MB581697B0367321CBAD04F9C4E7390@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <BYAPR04MB5749820C322B40C7DBBBCA02863F0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <fda88fd3-2d75-085e-ca15-a29f89c1e781@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30013d1d-c0d6-4932-3369-08d794c89eca
x-ms-traffictypediagnostic: BYAPR04MB4104:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4104C06BB1FB727ECDBD2DD4E7390@BYAPR04MB4104.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(53546011)(110136005)(26005)(33656002)(5660300002)(7696005)(7416002)(81156014)(316002)(9686003)(91956017)(186003)(6506007)(66446008)(54906003)(86362001)(55016002)(66556008)(66946007)(66476007)(81166006)(52536014)(966005)(64756008)(76116006)(8936002)(45080400002)(2906002)(4326008)(8676002)(71200400001)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4104;
 H:BYAPR04MB5816.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VbVaehMrledWPt6yMkpUavA4DRfF9v7kg8nwoeYLBvRzhHJQwjy0xq3obGRFeWS/l9yjYZbsiLc2nJ4M0JVu3fzd0bGWjCbhyHyWNZ2xtrK/V3+oAsJZABh93B3H7wUIFk5YpqgmtAmf51/albk1WyP/G64SO6inCPXB7CEmOXq7JwMlnDKIyCaKNzhuT4Gdm4KjRJ5cKxFFBHyVTz0WedvPihsFFNP+NQ7PUQVYnGGUdApOYOsV6Ig1G8yEXkC4Y0lZ+c0mdu5oML02g2e7b9nFBeipLI386BnR6WHr4f/JzPTx9BD6bkos8iNHmQ82Wfip5Krca5v+CxzJ3UDV8iHzf2o3RbiUcsH6P071vf7LUK8jFwRpTEgrIfZnB4AaoA4q1cceNl+SGh8vgMudJFI6qmc3IFGa5U7KCHWB+KhWy299Fv+x6smk9nl354IKWyCAJqKjI/UJcPfW7RICTFhfZ6dnG2LAEubY+QHxhD2MvYl4lSBkFHAYhRPIfFiezXm9WWugz0iFVPbuS1YD+g==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30013d1d-c0d6-4932-3369-08d794c89eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 05:56:07.3216 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGijyZy3owj+ys5nDb+xMAafJee9QabF9eFAn1SghlwLoSOilMql7s4jL+lDmEiKIneg/szVFeQl/2Wrjsn9FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_215615_610245_826020A8 
X-CRM114-Status: GOOD (  26.05  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "msnitzer@redhat.com" <msnitzer@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>, Stephen Bates <sbates@raithlin.com>,
 "roland@purestorage.com" <roland@purestorage.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>, "hare@suse.de" <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, "rwheeler@redhat.com" <rwheeler@redhat.com>,
 Christoph Hellwig <hch@lst.de>,
 "frederick.knight@netapp.com" <frederick.knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/01/09 12:19, Bart Van Assche wrote:
> On 2020-01-07 10:14, Chaitanya Kulkarni wrote:
>> * Current state of the work :-
>> -----------------------------------------------------------------------
>>
>> With [3] being hard to handle arbitrary DM/MD stacking without
>> splitting the command in two, one for copying IN and one for copying
>> OUT. Which is then demonstrated by the [4] why [3] it is not a suitable
>> candidate. Also, with [4] there is an unresolved problem with the
>> two-command approach about how to handle changes to the DM layout
>> between an IN and OUT operations.
> 
> Was this last discussed during the 2018 edition of LSF/MM (see also
> https://www.spinics.net/lists/linux-block/msg24986.html)? Has anyone
> taken notes during that session? I haven't found a report of that
> session in the official proceedings (https://lwn.net/Articles/752509/).

Yes, I think it was discussed but I do not think much progress has been
made. With NVMe simple copy added to the potential targets, I think it
is worthwhile to have this discussion again and come up with a clear plan.

> 
> Thanks,
> 
> Bart.
> 
> 
> This is my own collection with two year old notes about copy offloading
> for the Linux Kernel:
> 
> Potential Users
> * All dm-kcopyd users, e.g. dm-cache-target, dm-raid1, dm-snap, dm-thin,
>   dm-writecache and dm-zoned.
> * Local filesystems like BTRFS, f2fs and bcachefs: garbage collection
>   and RAID, at least if RAID is supported by the filesystem. Note: the
>   BTRFS_IOC_CLONE_RANGE ioctl is no longer supported. Applications
>   should use FICLONERANGE instead.
> * Network filesystems, e.g. NFS. Copying at the server side can reduce
>   network traffic significantly.
> * Linux SCSI initiator systems connected to SAN systems such that
>   copying can happen locally on the storage array. XCOPY is widely used
>   for provisioning virtual machine images.
> * Copy offloading in NVMe fabrics using PCIe peer-to-peer communication.
> 
> Requirements
> * The block layer must gain support for XCOPY. The new XCOPY API must
>   support asynchronous operation such that users of this API are not
>   blocked while the XCOPY operation is in progress.
> * Copying must be supported not only within a single storage device but
>   also between storage devices.
> * The SCSI sd driver must gain support for XCOPY.
> * A user space API must be added and that API must support asynchronous
>   (non-blocking) operation.
> * The block layer XCOPY primitive must be support by the device mapper.
> 
> SCSI Extended Copy (ANSI T10 SPC)
> The SCSI commands that support extended copy operations are:
> * POPULATE TOKEN + WRITE USING TOKEN.
> * EXTENDED COPY(LID1/4) + RECEIVE COPY STATUS(LID1/4). LID1 stands for a
>   List Identifier length of 1 byte and LID4 stands for a List Identifier
>   length of 4 bytes.
> * SPC-3 and before define EXTENDED COPY(LID1) (83h/00h). SPC-4 added
>   EXTENDED COPY(LID4) (83h/01h).
> 
> Existing Users and Implementations of SCSI XCOPY
> * VMware, which uses XCOPY (with a one-byte length ID, aka LID1).
> * Microsoft, which uses ODX (aka LID4 because it has a four-byte length
>   ID).
> * Storage vendors all support XCOPY, but ODX support is growing.
> 
> Block Layer Notes
> The block layer supports the following types of block drivers:
> * blk-mq request-based drivers.
> * make_request drivers.
> 
> Notes:
> With each request a list of bio's is associated.
> Since submit_bio() only accepts a single bio and not a bio list this
> means that all make_request block drivers process one bio at a time.
> 
> Device Mapper
> The device mapper core supports bio processing and blk-mq requests. The
> function in the device mapper that creates a request queue is called
> alloc_dev(). That function not only allocates a request queue but also
> associates a struct gendisk with the request queue. The
> DM_DEV_CREATE_CMD ioctl triggers a call of alloc_dev(). The
> DM_TABLE_LOAD ioctl loads a table definition. Loading a table definition
> causes the type of a dm device to be set to one of the following:
> DM_TYPE_NONE;
> DM_TYPE_BIO_BASED;
> DM_TYPE_REQUEST_BASED;
> DM_TYPE_MQ_REQUEST_BASED;
> DM_TYPE_DAX_BIO_BASED;
> DM_TYPE_NVME_BIO_BASED.
> 
> Device mapper drivers must implement target_type.map(),
> target_type.clone_and_map_rq() or both. .map() maps a bio list.
> .clone_and_map_rq() maps a single request. The multipath and error
> device mapper drivers implement both methods. All other dm drivers only
> implement the .map() method.
> 
> Device mapper bio processing
> submit_bio()
> -> generic_make_request()
>   -> dm_make_request()
>     -> __dm_make_request()
>       -> __split_and_process_bio()
>         -> __split_and_process_non_flush()
>           -> __clone_and_map_data_bio()
>           -> alloc_tio()
>           -> clone_bio()
>             -> bio_advance()
>           -> __map_bio()
> 
> Existing Linux Copy Offload APIs
> * The FICLONERANGE ioctl. From <include/linux/fs.h>:
>   #define FICLONERANGE _IOW(0x94, 13, struct file_clone_range)
> 
> struct file_clone_range {
> 	__s64 src_fd;
> 	__u64 src_offset;
> 	__u64 src_length;
> 	__u64 dest_offset;
> };
> 
> * The sendfile() system call. sendfile() copies a given number of bytes
>   from one file to another. The output offset is the offset of the
>   output file descriptor. The input offset is either the input file
>   descriptor offset or can be specified explicitly. The sendfile()
>   prototype is as follows:
>   ssize_t sendfile(int out_fd, int in_fd, off_t *ppos, size_t count);
>   ssize_t sendfile64(int out_fd, int in_fd, loff_t *ppos, size_t count);
> * The copy_file_range() system call. See also vfs_copy_file_range(). Its
>   prototype is as follows:
>   ssize_t copy_file_range(int fd_in, loff_t *off_in, int fd_out,
>      loff_t *off_out, size_t len, unsigned int flags);
> * The splice() system call is not appropriate for adding extended copy
>   functionality since it copies data from or to a pipe. Its prototype is
>   as follows:
>   long splice(struct file *in, loff_t *off_in, struct file *out,
>     loff_t *off_out, size_t len, unsigned int flags);
> 
> Existing Linux Block Layer Copy Offload Implementations
> * Martin Petersen's REQ_COPY bio, where source and destination block
>   device are both specified in the same bio. Only works for block
>   devices. Does not work for files. Adds a new blocking ioctl() for
>   XCOPY from user space.
> * Mikulas Patocka's approach: separate REQ_OP_COPY_WRITE and
>   REQ_OP_COPY_READ operations. These are sent individually down stacked
>   drivers and are paired by the driver at the bottom of the stack.
> 
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=6M3L=YQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2767CCA9EB9
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2019 20:34:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA89E20659
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2019 20:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tf1hcVIK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V9I9iGKK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PbIPx0Eu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA89E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=dfDwFi5ofjHEYe/IOdIIPGwmX6FUpCv4vogZgYINnOQ=; b=tf1hcVIKzx+mPp
	HxDXrh1Gc4Z+yczMVuMMJs0ApVUaSjurolCB8+tdXcXav1Fs3SyVQldZOb1TyftSM1kyOwJ+S+XXb
	hikhq5favyV2yQIK/D6biPSq5lMbbB68JR8gx/oJOOQGx92kGV+ZGoeT2YScjOKzGA7nfW6yupGYQ
	78idbOK2f8p2bkpgyL51AxZvPdT1FdD3YS5wJlFwwGwQhWQIffxrakBK5eo/EEiHmuquXDboJVu0c
	ZzBt9CInYfmclkIhfbL2w1ECXbxWtNHP+465DXrZvgMVCll2Q17Ns0VwjhZdc4dGLudOr7v0kfjea
	umugSvaWYC9x9tpPkNHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iNNL5-0007E8-4a; Wed, 23 Oct 2019 20:34:39 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNNL2-0007Dp-BI
 for linux-nvme@lists.infradead.org; Wed, 23 Oct 2019 20:34:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1571862876; x=1603398876;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=pd2UvNZNH/yTL/aKeu7APDOGSSPt2AGi4fO+rfpF9Io=;
 b=V9I9iGKK2o/0bJA8fCa6VDrgQOpHb+OVOl9a2PbvMXS9hyaqbCI3xW1Z
 aeLoIgNd7ncw72boc8+tC5nQFQFFujh/X8j+MaNl79TaI7wK0lqmsMOfL
 LAer6AYg7KkZo2tc/qhngVq+VZhnlq3sDpuaz+eayrLFXTQo3+X9NLDoT
 d9gz9EDa990j9GroRTcxPUM2Aob4i6Ow1uSKlGqk081isi5+hO8JPGD8U
 nhleu5BJDbSjP1LRrzzN5SmwXmssavZK5VeT/yxK2KyWjvcY12SirCJmd
 Ac6qdRkDJIwT84h6Cu53qZM/TTdGTKG1Nwoi/lRqFfng3QIyxJehUXl8U A==;
IronPort-SDR: oiotO1KfJ3dJwG93qEWGZEgYQLQW0Z7LvSiwiG4lOr4tUzMTl8WnkGC8zCjYqzAbSRPRkC3A/j
 MtTtjcSdPkn62kDnFQLVX9SSSEybMUUHBU+RZdwEtjTkPEyIYDESI0NzpT54Q7gDZ924m2Jt0p
 I/WS4LYk7rB19KGr+HoES4yXT/6q+VnOr+KdW5vR2eJjBdduQctzjN90eVnwdELPxzJoyvCWWd
 GG7KgolgNbs2jj5H9HDRCh5z3fqpxyYAo59a18DoUust9yo5UPgntVRUFH5GF2s5B506n9KC3O
 sy8=
X-IronPort-AV: E=Sophos;i="5.68,222,1569254400"; d="scan'208";a="125613233"
Received: from mail-by2nam05lp2059.outbound.protection.outlook.com (HELO
 NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.59])
 by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2019 04:34:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZLGnHlOREuHog9JKEvGqH+ORSMHV5gn4g/IQ0biyeTtwVKtcF2Rj0l87OIjmHrWqtXGLcHsHGEZ/SOsjzTKa2NKa0hPbESRJJnbVxkFKIHmBSEvRk08gAg2l9zGh8yqa9ldrsnohpptY9Dhpk6gbqrXgCupvgPxvqDbAQnN+aaPEaQKaUJ2WPdNTfx7weqQpy410rXl6ZubfJzzSQlgg8XJPnj7iFSyjJBq12Ph7j6WxekRFgeC/lsmUkVri4GkZ+dYA0Ejz9BZagez46rG7SI/dZ2yEM+1dbeYUNWOzsfA3QCRp2ucfymdUbon47NNDVp+5gP8EhK7y2xslk5xlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRPNcHQmCuSyDNwupW7XcqQKIPuJQ4A0klfwdboojmU=;
 b=LOpLmOQqAKX38u9B8jSPdU/G2FxI+unFJ2tVdnxddcCztw0EqoXl8fYBr9KvtGAoYwZQSTzU8rMUjmNXguFLb2Xd2LPnQVS/CTpCN/qUP1qrYPtrTneI5R+/hKJsWwVyoq1qpsltWTD+lkQck7fjaNnlO+l0Tlsodm2LbaY4n4ajrXXKptCygPlsBP54piAHDoOrJpd3Fx0pYUN2UmT83AgDhfxZ0l1IiBCeaaeQ9+6eUW8Di+eYnUXfIeTM0Y535UyAHqt00E++y64JisGMNnjBN9QiM3rYMXRZjnbQfS0xBia1L8FlAsz9qf8DHH8DAbzmsWRDzl1WE7rFHgLAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRPNcHQmCuSyDNwupW7XcqQKIPuJQ4A0klfwdboojmU=;
 b=PbIPx0EucDb+/JUvAUuL9mFFzP7MnHHHsFCAx52rtI7MgE/Mty0MmId4YuJKeYSrBBuBwZXnR4zMALeyPEzfZrvCztIsBnmedFrcQ9ycb1hbAbfpwfXodRwsS7p4QQeknnAdbsEoVtlf/4+qdtkORqWLuTm62YLgI+C8i8r/DNk=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4469.namprd04.prod.outlook.com (52.135.237.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 23 Oct 2019 20:34:34 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7%6]) with mapi id 15.20.2387.021; Wed, 23 Oct 2019
 20:34:34 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 7/7] nvmet: Open code nvmet_req_execute()
Thread-Topic: [PATCH 7/7] nvmet: Open code nvmet_req_execute()
Thread-Index: AQHVib/6nPsLqYy1yEqvZCLnovEzDg==
Date: Wed, 23 Oct 2019 20:34:34 +0000
Message-ID: <BYAPR04MB57490B2F11504A26F2166862866B0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191023163545.4193-1-logang@deltatee.com>
 <20191023163545.4193-8-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60a876fc-2b85-47c5-600b-08d757f86aaf
x-ms-traffictypediagnostic: BYAPR04MB4469:
x-microsoft-antispam-prvs: <BYAPR04MB4469EC298FDE35E8B3557D14866B0@BYAPR04MB4469.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(229853002)(52536014)(2906002)(476003)(2501003)(64756008)(7736002)(6506007)(25786009)(53546011)(99286004)(486006)(7696005)(305945005)(76116006)(76176011)(6116002)(55016002)(33656002)(3846002)(9686003)(66476007)(8936002)(66446008)(26005)(256004)(446003)(66556008)(8676002)(86362001)(186003)(66946007)(6436002)(74316002)(81166006)(81156014)(6246003)(54906003)(478600001)(71190400001)(71200400001)(66066001)(316002)(5660300002)(14454004)(4326008)(102836004)(110136005)(2201001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4469;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KC0W44eKSFAzrXpOI1/tSeez9Ij/TLS4YxzzBEL3zVsL8++ysqbj8xf2bvL6oQ/K9j2CFoedCtADtpgTiDqNnP43XkXIruNfbwqjL2t4urFgF/7+bI+Zol9w0SU2NBJu7Y/gVRAsMrfPSeoPS3l6NdCLF/Ow6Eoa17Abf/qTkwiohoJFwqTtlne365GNTwaLJjsjs+uXn4k+k5bCHJ85cFniE3TRPsS5NRqMLiS34uEEtArb085QoB+BTv++dFOmnl6MncJ0vMo4QOuKGYaGq85c87pYwVmoZcc8gTTcCwx9BYWpFNSFVPITiGDE5hBGirDZVdLT5ImCYxGXf/Iuff6VvMr1pet0QWXWpzBoyiMUwq3gkHhObEOaErnOD/v5MNdx6jNShbaICtYblXi/jIPCAHMDT920PrC5cAMOmOAKJ7cbTHP3fvGorIvutVMi
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a876fc-2b85-47c5-600b-08d757f86aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 20:34:34.8589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uf9YNZJkTISJ73hOoj16P2TFoaatuKYPF9rZybWsyUJ7mj2T55pROjlCiDTQY4rO51CYWbICpEacv0u1Ix7LbtBakxuDlDdy+yW9aXxPoK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4469
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191023_133436_467151_7FB3B80E 
X-CRM114-Status: GOOD (  15.21  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, Stephen Bates <sbates@raithlin.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

It doesn't hurt to keep that function, makes code easier to
read and search since it has been used in different places.

Anyways, looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

On 10/23/2019 09:36 AM, Logan Gunthorpe wrote:
> Now that nvmet_req_execute does nothing, open code it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [logang@deltatee.com: separated out of a larger draft patch from hch]
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/nvme/target/core.c  | 6 ------
>   drivers/nvme/target/fc.c    | 4 ++--
>   drivers/nvme/target/loop.c  | 2 +-
>   drivers/nvme/target/nvmet.h | 1 -
>   drivers/nvme/target/rdma.c  | 4 ++--
>   drivers/nvme/target/tcp.c   | 6 +++---
>   6 files changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 87fe82ccfa89..f7da0e50beeb 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -942,12 +942,6 @@ bool nvmet_check_data_len(struct nvmet_req *req, size_t data_len)
>   }
>   EXPORT_SYMBOL_GPL(nvmet_check_data_len);
>
> -void nvmet_req_execute(struct nvmet_req *req)
> -{
> -	req->execute(req);
> -}
> -EXPORT_SYMBOL_GPL(nvmet_req_execute);
> -
>   int nvmet_req_alloc_sgl(struct nvmet_req *req)
>   {
>   	struct pci_dev *p2p_dev = NULL;
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index ce8d819f86cc..7f9c11138b93 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -2015,7 +2015,7 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
>   		}
>
>   		/* data transfer complete, resume with nvmet layer */
> -		nvmet_req_execute(&fod->req);
> +		fod->req.execute(&fod->req);
>   		break;
>
>   	case NVMET_FCOP_READDATA:
> @@ -2231,7 +2231,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
>   	 * can invoke the nvmet_layer now. If read data, cmd completion will
>   	 * push the data
>   	 */
> -	nvmet_req_execute(&fod->req);
> +	fod->req.execute(&fod->req);
>   	return;
>
>   transport_error:
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index 11f5aea97d1b..f4b878b113f7 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -126,7 +126,7 @@ static void nvme_loop_execute_work(struct work_struct *work)
>   	struct nvme_loop_iod *iod =
>   		container_of(work, struct nvme_loop_iod, work);
>
> -	nvmet_req_execute(&iod->req);
> +	iod->req.execute(&iod->req);
>   }
>
>   static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index ff55f1005b35..46df45e837c9 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -374,7 +374,6 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
>   		struct nvmet_sq *sq, const struct nvmet_fabrics_ops *ops);
>   void nvmet_req_uninit(struct nvmet_req *req);
>   bool nvmet_check_data_len(struct nvmet_req *req, size_t data_len);
> -void nvmet_req_execute(struct nvmet_req *req);
>   void nvmet_req_complete(struct nvmet_req *req, u16 status);
>   int nvmet_req_alloc_sgl(struct nvmet_req *req);
>   void nvmet_req_free_sgl(struct nvmet_req *req);
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 36d906a7f70d..248e68da2e13 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -603,7 +603,7 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
>   		return;
>   	}
>
> -	nvmet_req_execute(&rsp->req);
> +	rsp->req.execute(&rsp->req);
>   }
>
>   static void nvmet_rdma_use_inline_sg(struct nvmet_rdma_rsp *rsp, u32 len,
> @@ -746,7 +746,7 @@ static bool nvmet_rdma_execute_command(struct nvmet_rdma_rsp *rsp)
>   				queue->cm_id->port_num, &rsp->read_cqe, NULL))
>   			nvmet_req_complete(&rsp->req, NVME_SC_DATA_XFER_ERROR);
>   	} else {
> -		nvmet_req_execute(&rsp->req);
> +		rsp->req.execute(&rsp->req);
>   	}
>
>   	return true;
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 3378480c49f6..af674fc0bb1e 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -930,7 +930,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
>   		goto out;
>   	}
>
> -	nvmet_req_execute(&queue->cmd->req);
> +	queue->cmd->req.execute(&queue->cmd->req);
>   out:
>   	nvmet_prepare_receive_pdu(queue);
>   	return ret;
> @@ -1050,7 +1050,7 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>   			nvmet_tcp_prep_recv_ddgst(cmd);
>   			return 0;
>   		}
> -		nvmet_req_execute(&cmd->req);
> +		cmd->req.execute(&cmd->req);
>   	}
>
>   	nvmet_prepare_receive_pdu(queue);
> @@ -1090,7 +1090,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
>
>   	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
>   	    cmd->rbytes_done == cmd->req.transfer_len)
> -		nvmet_req_execute(&cmd->req);
> +		cmd->req.execute(&cmd->req);
>   	ret = 0;
>   out:
>   	nvmet_prepare_receive_pdu(queue);
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

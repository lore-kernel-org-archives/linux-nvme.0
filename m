From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 29 Aug 2017 07:49:15 -0700
Subject: [PATCH V3] nvmet: Add support for HOST_ID feature.
In-Reply-To: <1503997982-13175-1-git-send-email-omri@excelero.com>
References: <1503997982-13175-1-git-send-email-omri@excelero.com>
Message-ID: <20170829144915.GA19316@infradead.org>

> +	case NVME_FEAT_HOST_ID:
> +		if (!(le32_to_cpu(req->cmd->common.cdw10[1]) & 1))
> +			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +		else
> +			status = nvmet_copy_to_sgl(req, 0,
> +					&req->sq->ctrl->hostid, 16);
> +		break;

The 16 here should be a sizeof(uuid_t) or sizeof(req->sq->ctrl->hostid),
but we can fix this up when applying the patch.

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>

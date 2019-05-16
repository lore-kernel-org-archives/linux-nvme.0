From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 16 May 2019 23:23:38 +0900
Subject: [PATCH 1/2] nvme: add thermal zone infrastructure
In-Reply-To: <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190516142337.GD24001@minwooim-desktop>

Hi Akinobu,

Great feature here, I think.

> -static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
> -		      void *buffer, size_t buflen, u32 *result)
> +static int nvme_features(struct nvme_ctrl *dev, u8 opcode, unsigned int fid,
> +			 unsigned int dword11, void *buffer, size_t buflen,
> +			 u32 *result)
>  {
>  	struct nvme_command c;
>  	union nvme_result res;
>  	int ret;
>  
>  	memset(&c, 0, sizeof(c));
> -	c.features.opcode = nvme_admin_set_features;
> +	c.features.opcode = opcode;
>  	c.features.fid = cpu_to_le32(fid);
>  	c.features.dword11 = cpu_to_le32(dword11);
>  
> @@ -1132,6 +1133,22 @@ static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword
>  	return ret;
>  }
>  
> +static int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
> +			     unsigned int dword11, void *buffer, size_t buflen,
> +			     u32 *result)
> +{
> +	return nvme_features(dev, nvme_admin_get_features, fid, dword11, buffer,
> +			     buflen, result);
> +}
> +
> +static int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
> +			     unsigned int dword11, void *buffer, size_t buflen,
> +			     u32 *result)
> +{
> +	return nvme_features(dev, nvme_admin_set_features, fid, dword11, buffer,
> +			     buflen, result);
> +}
> +

I think it's okay to separate this part from this patch. :)
(I guess I have seen this kind of patch from Keith, though)

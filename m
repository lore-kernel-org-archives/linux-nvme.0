From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 2 Jun 2019 00:11:54 -0700
Subject: [PATCH] nvme-cli: add default value for nsid of write-zeroes
In-Reply-To: <20190601070003.20142-1-minwoo.im.dev@gmail.com>
References: <20190601070003.20142-1-minwoo.im.dev@gmail.com>
Message-ID: <bfac4b78-937c-42e8-1be1-f9a81ad22ab7@grimberg.me>


> diff --git a/nvme.c b/nvme.c
> index 9819fcb..a7a96a1 100644
> --- a/nvme.c
> +++ b/nvme.c
> @@ -3731,6 +3731,7 @@ static int write_zeroes(int argc, char **argv, struct command *cmd, struct plugi
>   
>   	struct config cfg = {
>   		.start_block     = 0,
> +		.namespace_id    = 0,

This is implicitly set to 0. You should mention that you add this just
for clarification, and its not fixing a bug.

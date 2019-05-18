From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 18 May 2019 11:11:10 +0900
Subject: [PATCH V2 0/4] nvme-cli: Introduce nvme-status mapping with errno
In-Reply-To: <20190513170342.9497-1-minwoo.im.dev@gmail.com>
References: <20190513170342.9497-1-minwoo.im.dev@gmail.com>
Message-ID: <20190518021107.GA31204@minwooim-desktop>

On 19-05-14 02:03:38, Minwoo Im wrote:
> Hi,
> 
> This patchset introduces nvme-status module to manage mapping
> relationships between nvme error status and errno.  It cannot be
> directly mapped in 1:1, but we can figure out what kind of errors
> happended by the return value of nvme-cli.
> 
> NVMe status fields are 16bits to indicate, but UNIX return value from
> main() will be parsed in 8bits so that we need to do something about
> return value to indicate nvme error status.
> 
> Please review.
> Thanks,
> 
> Changes to previous C1:
>   - make switch-case inline in nvme-status (Chaitanya)
> 
> Minwoo Im (4):
>   nvme.h: Fix typos in status code values
>   nvme-status: Introduce nvme status module to map errno
>   nvme: Return errno mapped for nvme error status
>   fabrics: Return errno mapped for fabrics error status

Ping :)

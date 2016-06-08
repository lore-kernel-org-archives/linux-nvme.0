From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 7 Jun 2016 22:22:06 -0600
Subject: [PATCH V2] Use MACRO UINT_MAX instead of actual value
In-Reply-To: <1463471921-20261-1-git-send-email-mnghuan@gmail.com>
References: <1463471921-20261-1-git-send-email-mnghuan@gmail.com>
Message-ID: <57579D6E.10702@kernel.dk>

On 05/17/2016 01:58 AM, Minfei Huang wrote:
> It's more elegant to use MACRO UINT_MAX to represent the max value of
> type unsigned int. So replace the actual value by using this MACRO.

Added for 4.8, thanks.

-- 
Jens Axboe

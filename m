From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 17 Oct 2018 10:14:55 -0600
Subject: [PATCH 1/2] nvme-cli: Add get and set timestamp commands
In-Reply-To: <1539743178-6573-1-git-send-email-dong.ho@wdc.com>
References: <1539743178-6573-1-git-send-email-dong.ho@wdc.com>
Message-ID: <20181017161455.GA20375@localhost.localdomain>

On Tue, Oct 16, 2018@07:26:19PM +0000, Dong Ho wrote:
> +long get_current_time_in_ms(void)
> +{
> +    long            ms; // Milliseconds
> +    time_t          s;  // Seconds
> +    long            ts; // returned timestamp in ms
> +    struct timespec spec;
> +
> +    clock_gettime(CLOCK_REALTIME, &spec);
> +
> +    s  = spec.tv_sec;
> +    ms = round(spec.tv_nsec / 1.0e6); // Convert nanoseconds to milliseconds
> +    if (ms > 999) {
> +        s++;
> +        ms = 0;
> +    }
> +
> +    ts = 1000*s + ms;
> +
> +    return ts;
> +}

Regarding formatting, you have some indentations as tabs and others
as spaces. This program prefers the linux kernel coding style, so tabs
should be used consistently. Also, C89 comment /* style */
is preferred to //.

As to the feature itself, I don't think we should provide such a
convenience function as I don't see why this should be something a
user would want to set. The feature has in-kernel support to set if
supported. If anything for nvme-cli, this feature should be a subset of
the existing "set-feature" and "get-feature" commands rather than it's
own top-level command (which it already is).

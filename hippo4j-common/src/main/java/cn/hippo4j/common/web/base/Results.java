package cn.hippo4j.common.web.base;

import cn.hippo4j.common.web.exception.ErrorCodeEnum;
import cn.hippo4j.common.web.exception.ServiceException;

/**
 * Results.
 *
 * @author chen.ma
 * @date 2021/3/19 16:12
 */
public final class Results {

    public static Result<Void> success() {
        return new Result<Void>()
                .setCode(Result.SUCCESS_CODE);
    }

    public static <T> Result<T> success(T data) {
        return new Result<T>()
                .setCode(Result.SUCCESS_CODE)
                .setData(data);
    }

    public static <T> Result<T> failure(ServiceException serviceException) {
        return new Result<T>().setCode(ErrorCodeEnum.SERVICE_ERROR.getCode())
                .setMessage(serviceException.getMessage());
    }

    public static Result<Void> failure(Throwable throwable) {
        return new Result<Void>().setCode(ErrorCodeEnum.SERVICE_ERROR.getCode())
                .setMessage(throwable.getMessage());
    }

    public static <T> Result<T> failure(String code, String message) {
        return new Result<T>()
                .setCode(code)
                .setMessage(message);
    }

    public static <T> Result<T> failure(ErrorCodeEnum errorCode) {
        return new Result<T>()
                .setCode(errorCode.getCode())
                .setMessage(errorCode.getMessage());
    }

}

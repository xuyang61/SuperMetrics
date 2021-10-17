import React, { ComponentType } from 'react';
import styled from 'styled-components';
import { XCircle } from 'react-feather';
import { EvaluatedKitty } from '../types/EvaluatedKitty';

interface Props {
    kitty: EvaluatedKitty;
    onDelete?: (name: string) => unknown;
}

const CardContainer = styled.div`
    display: flex;
    position: relative;
    flex-direction: column;
    align-items: center;
    max-width: 250px;
    max-height: 350px;
    border: 1px solid black;
    box-sizing: border-box;
    padding: 5px 25px 20px 25px;
`;

const Name = styled.span`
    font-size: 20pt;
    flex: none;
`;

const ImageContainer = styled.div`
    flex: 1;
    max-height: 250px;
    overflow: hidden;
`;

const Image = styled.img`
    height: auto;
    width: auto;
    max-width: 100%;
    max-height: 100%;
`;

const CloseIcon = styled(XCircle)`
    position: absolute;
    right: 5px;
    top: 5px;
    color: red;
`;

export const KittyCard: ComponentType<Props> = ({
    kitty: { name, pictureUrl },
    onDelete,
}) => {
    return (
        <CardContainer>
            <Name>{name}</Name>
            {onDelete ? <CloseIcon onClick={() => onDelete(name)} /> : null}
            <ImageContainer>
                <Image src={pictureUrl} />
            </ImageContainer>
        </CardContainer>
    );
};
